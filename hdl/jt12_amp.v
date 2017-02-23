`timescale 1ns / 1ps


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
	Date: 23-2-2017	
	
*/



`timescale 1ns / 1ps

module jt12_amp(
	input			clk,
	input			sample,
	input	[2:0]	volume,

	input		signed	[13:0]	pre,	
	output	reg signed	[15:0]	post
);

wire signed [14:0] x2 = pre<<<1;
wire signed [15:0] x3 = x2+pre;
wire signed [15:0] x4 = pre<<<2;
wire signed [16:0] x5 = x4+pre;
wire signed [16:0] x6 = x4+x2;
wire signed [16:0] x7 = x4+x3;

always @(posedge clk)
if( sample )
	case( volume ) 
		3'd0: // /2
			post <= { {2{pre[13]}}, pre	};
		3'd1: // x1
			post <= { x2[14], x2	};
		3'd2: // x2
			post <= { x2, 1'd0   	};
		3'd3: // x3
			case( x3[15:14] )
				2'b00, 2'b11: post <= { x3[14:0], 1'd0 };
				2'b01: post <= 16'h7FFF;
				2'b10: post <= 16'h8000;
			endcase
		3'd4: // x4
			case( x4[15:14] )
				2'b00, 2'b11: post <= { x4[14:0], 1'd0 };
				2'b01: post <= 16'h7FFF;
				2'b10: post <= 16'h8000;
			endcase		
		3'd5: // x5
			case( x5[16:15] )
				2'b00, 2'b11: post <= x5[15:0];
				2'b01: post <= 16'h7FFF;
				2'b10: post <= 16'h8000;
			endcase				
		3'd6: // x6
			case( x6[16:15] )
				2'b00, 2'b11: post <= x6[15:0];
				2'b01: post <= 16'h7FFF;
				2'b10: post <= 16'h8000;
			endcase				
		3'd7: // x7
			case( x7[16:15] )
				2'b00, 2'b11: post <= x7[15:0];
				2'b01: post <= 16'h7FFF;
				2'b10: post <= 16'h8000;
			endcase			
	endcase

endmodule

module jt12_amp_stereo(
	input			clk,
	input			sample,
	input	signed	[13:0]	preleft,
	input	signed	[13:0]	preright,
	input	[2:0]	volume,
	
	output	signed	[15:0]	postleft,
	output	signed	[15:0]	postright
);

jt12_amp amp_left(
	.clk	( clk		),
	.sample	( sample	),
	.pre	( preleft	),
	.post	( postleft	),
	.volume	( volume	)
);

jt12_amp amp_right(
	.clk	( clk		),
	.sample	( sample	),
	.pre	( preright	),
	.post	( postright	),
	.volume	( volume	)
);

endmodule
