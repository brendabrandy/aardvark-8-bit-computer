//////////////////////////////////////////////////////////////////////////////////
// Created by: Team Aardvark
// Course: Cooper Union ECE151A Spring 2016
// Professor: Professor Marano
// Module Name: 
// Description: 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ns

module register_file (rt_data, rs_data, s0_data, s1_data, sp_data, ra_data, regWrite, beqctrl, jrctrl, ALUsrc, rt_addr, rs_addr, dataToWrite, slt_reg, rs_write_addr);

input wire regWrite;
input wire beqctrl;
input wire jrctrl;
input wire ALUsrc;		//I type control for immediate
input wire [1:0] rt_addr;
input wire [1:0] rs_addr;
input wire [7:0] dataToWrite;
input wire [1:0] slt_reg;	
input wire [1:0] rs_write_addr;

output reg [7:0] rt_data;
output reg [7:0] rs_data;

output reg [7:0] s0_data;
output reg [7:0] s1_data;
output reg [7:0] sp_data;
output reg [7:0] ra_data;

reg [7:0] data_reg [3:0]; 	 
reg [1:0] address_reg [3:0];	//3:$ra, 2:$sp, 1: $s1, 0: $s0
reg [7:0] t0;
reg [7:0] t1;



//------------------Instructions-----------------------
initial 
	begin
		
		address_reg[3] = 2'b11;		//addr of ra
		address_reg[2] = 2'b10;		//addr of sp
		address_reg[1] = 2'b01;		//addr of s1
		address_reg[0] = 2'b00;		//addr of s0
		data_reg[3] = 8'b00000100;	//data of ra 
		data_reg[2] = 8'b11111111;	//data of sp
		data_reg[1] = 8'b00001000;	//data of s1
		data_reg[0] = 8'b01000000;	//data of s0
		t0 = 8'b00000000;
		t1 = 8'b00000000;
		
		rt_data = 8'b00000000;
		rs_data = 8'b00000000;
		s0_data = 0;
		s1_data = 0;
		sp_data = 0;
		ra_data = 0;
	end

//when there is an input address, data reg at that input address = its dataReadReg
always @*
	begin
	if (beqctrl == 0) 
		begin
			rt_data = data_reg[rt_addr];
			if (jrctrl == 1) begin					//jrctrl = 1 for JR type
				rs_data = data_reg[rs_write_addr];	//when jrctrl, rs_write_addr = 11 (addr of $ra)
			end if (ALUsrc == 1) begin				//ALUsrc = 1 for I type
				rs_data = data_reg[2]; 				//rs_data holds the data of $sp
			end 
		end 
		if (regWrite == 1) 
			begin
				if(dataToWrite)
					#1 data_reg[address_reg[1]] = dataToWrite;		//rs_addr = address_reg[1] = write register address
				end if (slt_reg == 2'b10) begin
					t0 = #1 dataToWrite;
				end if (slt_reg == 2'b11) begin
					t1 = #1 dataToWrite;
				end if (beqctrl == 1) begin
					//$display("Hello!");
					rt_data = t0;
					rs_data = t1;
			end
	end
always @*
begin
	s0_data = data_reg[0];
	s1_data = data_reg[1];
	sp_data = data_reg[2];
	ra_data = data_reg[3];

end
endmodule
