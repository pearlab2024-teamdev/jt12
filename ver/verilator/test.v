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
    Date: 27-1-2017 
    
    Each channel can use the full range of the DAC as they do not
    get summed in the real chip.

    Operator data is summed up without adding extra bits. This is
    the case of real YM3438, which was used on Megadrive 2 models.


*/



module top(
    input           rst,        // rst should be at least 6 clk&cen cycles long
    input           clk,        // CPU clock
    input           cen,        // optional clock enable, it not needed leave as 1'b1
    input   [7:0]   din,
    input   [1:0]   addr,
    input           cs_n,
    input           wr_n,
    
    output  [7:0]   dout,
    output          irq_n,
    // combined output
    output  signed  [15:0]  snd_right,
    output  signed  [15:0]  snd_left,
    output          snd_sample,
    // Megadrive PSG
    input           psg_wr_n,
    output   [10:0] psg_snd,
    output          psg_ready
);

`ifdef YM2203
localparam use_lfo=0, use_ssg=1, num_ch=3, use_pcm=0, use_lr=0;
`else // YM2612
localparam use_lfo=1, use_ssg=0, num_ch=6, use_pcm=1, use_lr=1;
`endif


jt12 #(.use_lfo(use_lfo),.use_ssg(use_ssg), 
    .num_ch(num_ch), .use_pcm(use_pcm), .use_lr(use_lr) ) 
u_jt12(
    .rst            ( rst       ),        // rst should be at least 6 clk&cen cycles long
    .clk            ( clk       ),        // CPU clock
    .cen            ( cen       ),        // optional clock enable, it not needed leave as 1'b1
    .din            ( din       ),
    .addr           ( addr      ),
    .cs_n           ( cs_n      ),
    .wr_n           ( wr_n      ),
    
    .dout           ( dout      ),
    .irq_n          ( irq_n     ),

    .snd_right      ( snd_right ),
    .snd_left       ( snd_left  ),
    .snd_sample     ( snd_sample)
);

`ifdef MEGADRIVE_PSG
reg psg_cen;
reg [3:0] psg_cen_cnt;

always @(posedge clk)
    if( rst ) psg_cen_cnt <= 4'd0;
    else psg_cen_cnt <= (psg_cen_cnt==4'he) ? 4'h0 : psg_cen_cnt+4'h1;

always @(negedge clk)
    psg_cen <= !psg_cen_cnt[0] && psg_cen_cnt!=4'he;

jt89 u_jt89(
    .rst            ( rst       ),        // rst should be at least 6 clk&cen cycles long
    .clk            ( clk       ),        // CPU clock
    .clk_en         ( psg_cen   ),
    .wr_n           ( psg_wr_n  ),
    .din            ( din       ),
    .sound          ( psg_snd   ),
    .ready          ( psg_ready )
);
`else 
    assign psg_snd   = 11'd0;
    assign psg_ready = 1'b1;
`endif

endmodule // jt03