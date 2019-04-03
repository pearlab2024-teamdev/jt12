/* This file is part of JT12.


    JT12 program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    JT12 program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with JT12.  If not, see <http://www.gnu.org/licenses/>.

    Author: Jose Tejada Gomez. Twitter: @topapate
    Version: 1.0
    Date: 21-03-2019
*/

module jt10_adpcm_drvA(
    input           rst_n,
    input           clk,    // CPU clock
    input           cen,    // clk & cen = 666 kHz
    input           cen3,   // clk & cen = 111 kHz

    output  [19:0]  addr,  // real hardware has 10 pins multiplexed through RMPX pin
    output  [3:0]   bank,
    output  reg     roe_n, // ADPCM-A ROM output enable

    // Control Registers
    input   [5:0]   atl,        // ADPCM Total Level
    input   [7:0]   lracl_in,
    input   [15:0]  addr_in,

    input   [2:0]   up_lracl,
    input           up_start,
    input           up_end,
    input   [2:0]   up_addr,

    input   [7:0]   aon_cmd,    // ADPCM ON equivalent to key on for FM

    input   [7:0]   datain,

    // Flags
    output  [5:0]   flags,
    input   [5:0]   clr_flags,

    output reg signed [15:0]  pcm55_l,
    output reg signed [15:0]  pcm55_r
);

reg  [3:0] data;
wire nibble_sel;

always @(posedge clk or negedge rst_n)
    if( !rst_n ) begin
        data <= 4'd0;
    end else if(cen) begin
        data <= !nibble_sel ? datain[7:4] : datain[3:0];
    end

reg [ 5:0] up_start_sr, up_end_sr, aon_sr, aoff_sr, up_lracl_sr;
reg [ 2:0] chlin, chfast;
reg [15:0] addr_in2;

reg [5:0] up_addr_dec;
always @(*)
    case(up_addr)
        3'd0: up_addr_dec = 6'b000_001;
        3'd1: up_addr_dec = 6'b000_010;
        3'd2: up_addr_dec = 6'b000_100;
        3'd3: up_addr_dec = 6'b001_000;
        3'd4: up_addr_dec = 6'b010_000;
        3'd5: up_addr_dec = 6'b100_000;
        default: up_addr_dec = 6'd0;
    endcase // up_addr

reg [5:0] up_lr_dec;
always @(*)
    case(up_lracl)
        3'd3: up_lr_dec = 6'b000_001;
        3'd4: up_lr_dec = 6'b000_010;
        3'd5: up_lr_dec = 6'b000_100;
        3'd0: up_lr_dec = 6'b001_000;
        3'd1: up_lr_dec = 6'b010_000;
        3'd2: up_lr_dec = 6'b100_000;
        default: up_lr_dec = 6'd0;
    endcase // up_addr

reg div3;

reg  [4:0]  cnt;
wire [4:0] next = cnt==5'd17 ? 5'd0 : cnt + 5'd1;
reg cen_addr_mask =1'b0;
reg cen6_mask = 1'b0;

always @(negedge clk) begin
    cen_addr_mask <= cnt<5'd7;
    cen6_mask     <= cnt=='d8;
end

wire cen_addr = cen_addr_mask & cen;
wire cen6 = cen6_mask & cen;

reg [7:0] lracl_in2;

always @(posedge clk or negedge rst_n)
    if( !rst_n ) begin
        cnt    <= 'd0;
    end else if(cen) begin
        cnt <= next;
    end


always @(posedge clk or negedge rst_n)
    if( !rst_n ) begin
        chlin  <= 'd0;
        up_start_sr <= 'd0;
        up_end_sr   <= 'd0;
        aon_sr      <= 'd0;
        aoff_sr     <= 'd0;
        div3        <= 'd0;
    end else if(cen_addr) begin
        div3 <= cnt==5'd5;
        // input new addresses
        chfast <= chfast==3'd5 ? 3'd0 : chfast+3'd1;
        if( chfast==3'd5 ) begin // delay one clock cycle to synchronize with up_*_sr registers
            addr_in2  <= addr_in; 
            lracl_in2 <= lracl_in;
        end
        up_start_sr <= chfast==5 &&    up_start ?  up_addr_dec : { 1'b0, up_start_sr[5:1] };
        up_end_sr   <= chfast==5 &&      up_end ?  up_addr_dec : { 1'b0, up_end_sr[5:1]   };
        aon_sr      <= chfast==5 && !aon_cmd[7] ? aon_cmd[5:0] : { 1'b0, aon_sr[5:1]      };
        aoff_sr     <= chfast==5 &&  aon_cmd[7] ? aon_cmd[5:0] : { 1'b0, aoff_sr[5:1]     };
        up_lracl_sr <= chfast==5                ?    up_lr_dec : { 1'b0, up_lracl_sr[5:1] };
    end

jt10_adpcm_cnt u_cnt(
    .rst_n       ( rst_n           ),
    .clk         ( clk             ),
    .cen         ( cen_addr        ),
    .div3        ( div3            ),
    .addr_in     ( addr_in2        ),
    .up_start    ( up_start_sr[0]  ),
    .up_end      ( up_end_sr[0]    ),
    .aon         ( aon_sr[0]       ),
    .aoff        ( aoff_sr[0]      ),
    .addr_out    ( addr            ),
    .bank        ( bank            ),
    .sel         ( nibble_sel      ),
    .roe_n       ( roe_n           ),
    .flags       ( flags           ),
    .clr_flags   ( clr_flags       )
);

reg chon;
always @(posedge clk) if(cen) chon <= ~roe_n;

// wire chactive = chon & cen6;
wire signed [15:0] pcmdec;

jt10_adpcm u_decoder(
    .rst_n  ( rst_n     ),
    .clk    ( clk       ),
    .cen    ( cen6      ),
    .data   ( data      ),
    .chon   ( chon      ),
    .pcm    ( pcmdec    )
);

`ifdef SIMULATION
integer fch0, fch1, fch2, fch3, fch4, fch5;
initial begin
    fch0 = $fopen("ch0.dec","w");
    fch1 = $fopen("ch1.dec","w");
    fch2 = $fopen("ch2.dec","w");
    fch3 = $fopen("ch3.dec","w");
    fch4 = $fopen("ch4.dec","w");
    fch5 = $fopen("ch5.dec","w");
end

reg signed [15:0] pcm_ch0, pcm_ch1, pcm_ch2, pcm_ch3, pcm_ch4, pcm_ch5;
always @(negedge cen6) begin
    if(chfast==3'd0) begin
        pcm_ch0 <= pcmdec;
        $fwrite( fch0, "%d\n", pcmdec );
    end
    if(chfast==3'd1) begin
        pcm_ch1 <= pcmdec;
        $fwrite( fch1, "%d\n", pcmdec );
    end
    if(chfast==3'd2) begin
        pcm_ch2 <= pcmdec;
        $fwrite( fch2, "%d\n", pcmdec );
    end
    if(chfast==3'd3) begin
        pcm_ch3 <= pcmdec;
        $fwrite( fch3, "%d\n", pcmdec );
    end
    if(chfast==3'd4) begin
        pcm_ch4 <= pcmdec;
        $fwrite( fch4, "%d\n", pcmdec );
    end
    if(chfast==3'd5) begin
        pcm_ch5 <= pcmdec;
        $fwrite( fch5, "%d\n", pcmdec );
    end    
end
`endif

wire signed [15:0] pcm18_l, pcm18_r;

always @(posedge clk) begin
    if( cen3 && chon ) begin
        pcm55_l <= pre_pcm55_l;
        pcm55_r <= pre_pcm55_r;
    end
end

jt10_adpcm_gain u_gain(
    .rst_n  ( rst_n          ),
    .clk    ( clk            ),
    .cen    ( cen_addr       ),
    .div3   ( div3           ),
    .lracl  ( lracl_in2      ),
    //.lracl  ( 8'hff      ),
    .atl    ( atl            ),        // ADPCM Total Level
    .up     ( up_lracl_sr[0] ),
    //.up(1'b1),
    .pcm_in ( pcmdec         ),
    .pcm_l  ( pcm18_l        ),
    .pcm_r  ( pcm18_r        )
);

wire signed [15:0] pre_pcm55_l, pre_pcm55_r;

// assign pcm55_l = pre_pcm55_l;
// assign pcm55_r = pre_pcm55_r;

jt10_adpcm_acc u_acc_left(
    .rst_n  ( rst_n     ),
    .clk    ( clk       ),
    .cen    ( cen6      ),
    .cur_ch ( chfast    ),
    .pcm_in ( pcm18_l   ),    // 18.5 kHz
    .pcm_out( pre_pcm55_l   )     // 55.5 kHz
);

jt10_adpcm_acc u_acc_right(
    .rst_n  ( rst_n     ),
    .clk    ( clk       ),
    .cen    ( cen6      ),
    .cur_ch ( chfast    ),
    .pcm_in ( pcm18_r   ),    // 18.5 kHz
    .pcm_out( pre_pcm55_r   )     // 55.5 kHz
);



endmodule // jt10_adpcm_drvA