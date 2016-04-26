`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:20:37 04/24/2016 
// Design Name: 
// Module Name:    alu_simple 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu_1(data1, data2, zero);

//?????????????Input Ports?????????????????????????????

input data1;	//8 bits of data
input data2;	//8 bits of data

//?????????????Output Ports????????????????????????????

output zero; 			//returns 1 if equal

//?????????????Input ports Data Type???????????????????
// By rule all the input ports should be wires
wire data1;	//8 bits of data
wire data2;	//8 bits of data

//?????????????Output Ports Data Type??????????????????
// Output port can be a storage element (reg) or a wire
reg zero;

//??????----?-??????Instructions---???????????????--???
always begin
	zero = 0;
	if (data1 == data2)
		zero = 1;
	if (data1 != data2)
		zero = 0;
end

endmodule