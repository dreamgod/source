`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:10 08/10/2014 
// Design Name: 
// Module Name:    top 
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
module Data_Out_Pro(
	input           CLK_250M ,
	input   [63:0]  Data_PCIE_i,
	input           Valid_PCIE_i,
	input 			DataSendCLK,
	output          FIFO_C1_Full,
	output  reg [15:0]  DataSend,
	output  reg         DataSendisK
    );



wire [15:0]GTX_DATA;
wire [15:0]Out_dout;

reg [15:0]Out_dout_r=0;

reg KIsComing=0; // it tell us K Char is Coming
reg [3:0]read_counter_i=0; 

reg  [16:0]addrb=0;
reg wea=0;
reg [14:0]WriteLength=0;
reg [14:0]WriteLength_r=0;
reg [14:0]WriteLength_r1=0;
	
always @ (posedge DataSendCLK )
begin 
Out_dout_r <= Out_dout;
end 
reg Valid,Valid_r;
always @ (posedge DataSendCLK)
	if(addrb>0)begin
		Valid <= 1'b1;
	end 
	else begin 
		Valid <= 1'b0;
	end 
always @ (posedge DataSendCLK )begin 
Valid_r <= Valid;
end 
assign GTX_DATA = Valid_r ? Out_dout_r : {12'b0,read_counter_i};



reg sendstate = 0;
//add new 8-10
reg StartSend_q,StartSend_q1,StartSend_q2;	

reg StartSend =0;
reg [14:0]addra=0;
always @ (posedge DataSendCLK)
begin 
	StartSend_q <= StartSend;
	StartSend_q1 <= StartSend_q;
	StartSend_q2 <= StartSend_q1;
	WriteLength_r  <= WriteLength;
	WriteLength_r1 <= WriteLength_r; 
end 
//add new 8-10

always @ (posedge DataSendCLK)
case (sendstate)
0:if(StartSend_q2)begin  //change 
	sendstate <= sendstate + 1'b1;
	addrb <= 0; 
   end 
   else begin 
   sendstate <= sendstate;   

   end 
1:if(addrb>=(WriteLength_r1*4+3+1))begin   // because 0 is not valid 
		sendstate <= 0;
		addrb <= 0;
		end 
	else begin 
		sendstate <= sendstate;
		if(!KIsComing)begin
		addrb <= addrb + 1'b1;
			end
		else begin
		addrb <= addrb;
	   end  
	 end 
default:begin 
	sendstate <= 0;
	addrb <= 0;
end 
endcase 
	



always @ (posedge DataSendCLK)
 if(read_counter_i == 4'd12)begin
			KIsComing <= 1'b1;
	end
else begin
			KIsComing <= 1'b0;
	end
		

always @(posedge DataSendCLK)
 if(read_counter_i == 4'd0)             // 插入K字头过程 
    begin		  
        DataSend        <=16'h50bc             ;   
        DataSendisK     <= 1'b1                ;
        read_counter_i <=read_counter_i + 1'd1;
    end
  else
    begin		                                // 数据发送过程
        DataSend        <=GTX_DATA            ;   
        DataSendisK     <= 1'b0                ;
        read_counter_i  <=read_counter_i + 1'd1;
    end

////////////////////////////////////////////////////////
reg [63:0]Data_PCIE_q1;
reg [63:0]Data_PCIE_q2;
reg [63:0]Data_PCIE_q;
reg Valid_PCIE_q,Valid_PCIE_q1,Valid_PCIE_q2;

reg [2:0]state;
always @ (posedge CLK_250M)
case(state)	
//catch frame head
0:if(Data_PCIE_q1[63:32]==32'hA0AA_A0AA )begin 
		WriteLength <= Data_PCIE_q1[15:2]+ 1'd1+ (Data_PCIE_q1[1]&Data_PCIE_q[0]);
		wea <= 1'b1;
		state <= state + 1'b1;
	end 
	else begin 
		state <= state;
		wea <= 1'b0;
		WriteLength <= WriteLength;
	end 
//write to RAM 
1:if(addra >= WriteLength)begin 
		StartSend <= 1'b1;
		wea <= 1'b0;
		state <= state +1'b1 ;
		end 
	else begin 
		StartSend <= 1'b0;
		wea<=1'b1;
		state <= state;
	end 
2,3,4:begin 
	state <= state +1'b1 ;
	StartSend <= 1'b1;
	wea <= 1'b0;
end 
5:begin 
	state <= 0 ;
	StartSend <= 1'b0;
	wea <= 1'b0;	
end 
default:begin 
WriteLength <= 0;
wea <=0;
state <=0;
end 
endcase 


always @ (posedge CLK_250M)
begin
Data_PCIE_q   <= Data_PCIE_i;
Data_PCIE_q1  <= Data_PCIE_q;
Data_PCIE_q2  <= {Data_PCIE_q1[15:0],Data_PCIE_q1[31:16],Data_PCIE_q1[47:32],Data_PCIE_q1[63:48]};
Valid_PCIE_q  <= Valid_PCIE_i;
Valid_PCIE_q1 <= Valid_PCIE_q;
Valid_PCIE_q2 <= Valid_PCIE_q1;
end

always @ (posedge CLK_250M)
	if(Valid_PCIE_q2 && wea)begin 
		addra <= addra + 1'b1;
	end 
	else if(StartSend)begin 
		 addra <= 0;
		 end 
		 else begin 
		 addra <= addra;
		 end 

RAM_64_16 Data64_16 (
  .clka(CLK_250M), // input clka
  .ena(1'b1), // input ena
  .wea(wea), // input [0 : 0] wea
  .addra(addra), // input [14 : 0] addra
  .dina(Data_PCIE_q2), // input [63 : 0] dina
  .clkb(DataSendCLK), // input clkb
  .addrb(addrb), // input [16 : 0] addrb
  .doutb(Out_dout) // output [15 : 0] doutb
);
// INST_TAG_END ------ End INSTANTIATION Template ---------
assign FIFO_C1_Full = 0;

endmodule
