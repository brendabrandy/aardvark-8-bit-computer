//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module ctrl(jctrl, jrctrl, memWrite, memRead, memToReg, ALUop, ALUsrc, nextctrl, regWrite, beqctrl, ractrl, jalctrl, sltctrl, inst1, inst2);

//-------------Input Ports-----------------------------
input wire [2:0] inst1;
input wire inst2;

//-------------Output Ports----------------------------

output reg jctrl;
output reg jrctrl;
output reg memWrite;
output reg memRead;
output reg [1:0] memToReg;
output reg [2:0]ALUop;
output reg ALUsrc;
output reg regWrite;
output reg beqctrl;
output reg ractrl;
output reg jalctrl;
output reg [1:0]sltctrl;	//see whether the control is slt_0 or slt_1

output reg [3:0] instructions;

//------------------Instructions-----------------------
initial
	begin
		jctrl = 0;
		jrctrl = 0;
		memWrite = 0;
		memRead = 0;
		memToReg = 2'b00;
		ALUop = 3'b000;
		ALUsrc = 0;
		regWrite = 0;
		beqctrl = 0;
		ractrl = 0;
		jalctrl = 0;
		sltctrl = 0;
		instructions = {inst1,inst2};
	end
always @*
begin
	instructions = {inst1,inst2};
	
	case(instructions)

	4'b0001: begin	//add
			$display("add");
			ALUop = 3'b000;
			regWrite = 1;

			jctrl = 0;
			jrctrl = 0;
			memWrite = 0;
			memRead = 0;
			memToReg = 2'b00;
			ALUsrc = 0;
			beqctrl = 0;
			ractrl = 0;
			jalctrl = 0;
			sltctrl = 0;
	end 
	4'b0011: begin	//nand
				$display("nand");
				ALUop = 3'b001;
				regWrite = 1;

				jctrl = 0;
				jrctrl = 0;
				memWrite = 0;
				memRead = 0;
				memToReg = 2'b00;
				ALUsrc = 0;
				beqctrl = 0;
				ractrl = 0;
				jalctrl = 0;
				sltctrl = 0;
			end
	4'b0100: begin	//slt_0
				$display("slt_0");
				ALUop = 3'b010;
				regWrite = 1;
				sltctrl = 2'b10;
												
				jctrl = 0;
				jrctrl = 0;
				memWrite = 0;
				memRead = 0;
				memToReg = 2'b00;
				ALUsrc = 0;
				beqctrl = 0;
				ractrl = 0;
				jalctrl = 0;
			end
	4'b0101: begin	//slt_1
				$display("slt_1");
				ALUop = 3'b010;
				regWrite = 1;
				sltctrl = 2'b11;

				jctrl = 0;
				jrctrl = 0;
				memWrite = 0;
				memRead = 0;
				memToReg = 2'b00;
				ALUsrc = 0;
				beqctrl = 0;
				ractrl = 0;
				jalctrl = 0;
			end
	4'b0110: begin	//sl
				$display("sl");
				ALUop = 3'b011;
				regWrite = 1;

				jctrl = 0;
				jrctrl = 0;
				memWrite = 0;
				memRead = 0;
				memToReg = 2'b00;
				ALUsrc = 0;
				beqctrl = 0;
				ractrl = 0;
				jalctrl = 0;
				sltctrl = 0;	
			end
	4'b0111: begin	//sr
				$display("sr");
				ALUop = 3'b100;
				regWrite = 1;

				jctrl = 0;
				jrctrl = 0;
				memWrite = 0;
				memRead = 0;
				memToReg = 2'b00;
				ALUsrc = 0;
				beqctrl = 0;
				ractrl = 0;
				jalctrl = 0;
				sltctrl = 0;
			end
	4'b1000: begin	//lw
				$display("lw");
				ALUop = 111;
				memRead = 1;
				memToReg = 2'b01;
				regWrite = 1;
				ALUsrc = 1;

				jctrl = 0;
				jrctrl = 0;
				memWrite = 0;
				beqctrl = 0;
				ractrl = 0;
				jalctrl = 0;
				sltctrl = 0;
			end
	4'b1001: begin //sw
				$display("sw");
				ALUop = 111;
				memWrite = 1;
				ALUsrc = 1;

				jctrl = 0;
				jrctrl = 0;
				memRead = 0;
				memToReg = 2'b00;
				regWrite = 0;
				beqctrl = 0;
				ractrl = 0;
				jalctrl = 0;
				sltctrl = 0;
			end
	4'b1010: begin	//addi 
				$display("addi");
				ALUop = 3'b100;
				regWrite = 1;
				ALUsrc = 1;
				
				jctrl = 0;
				jrctrl = 0;
				memWrite = 0;
				memRead = 0;
				memToReg = 2'b00;
				beqctrl = 0;
				ractrl = 0;
				jalctrl = 0;
				sltctrl = 0;
			end
	4'b1011: begin	//jr
				$display("jr");
				jrctrl = 1;
				ractrl = 1;	//controls mux

				jctrl = 0;
				memWrite = 0;
				memRead = 0;
				memToReg = 2'b00;
				ALUop = 3'b000;
				ALUsrc = 0;
				regWrite = 0;
				beqctrl = 0;
				jalctrl = 0;
				sltctrl = 0;
			end
	4'b1100: begin	//beq	
				$display("beq");
				ALUop = 3'b101;
				jctrl = 1;
				beqctrl = 1;
				jalctrl = 1;

				jrctrl = 0;
				memWrite = 0;
				memRead = 0;
				memToReg = 2'b00;
				ALUsrc = 0;
				regWrite = 0;
				ractrl = 0;
				sltctrl = 0;
			end
	4'b1110: begin //jal
				$display("jal");
				jctrl = 1;
				memToReg = 2'b10;
				jalctrl = 1;

				jrctrl = 0;
				memWrite = 0;
				memRead = 0;
				ALUop = 3'b000;
				ALUsrc = 0;
				regWrite = 0;
				beqctrl = 0;
				ractrl = 0;
				sltctrl = 0;
			end
	default: begin
				$display("default");
				jctrl = 0;
				jrctrl = 0;
				memWrite = 0;
				memRead = 0;
				memToReg = 2'b00;
				ALUop = 3'b000;
				ALUsrc = 0;
				regWrite = 0;
				beqctrl = 0;
				ractrl = 0;
			end
	endcase
			
end
	
endmodule