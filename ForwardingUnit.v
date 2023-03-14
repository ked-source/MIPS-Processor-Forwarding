module ForwardingUnit(Operand1_MUX, Operand2_MUX, EX_MEM_RegWrite, MEM_WB_RegWrite, ID_EX_rs, ID_EX_rt, EX_MEM_rd, MEM_WB_rd);

output reg[1:0] Operand1_MUX, Operand2_MUX;
input wire EX_MEM_RegWrite, MEM_WB_RegWrite;
input wire[4:0] ID_EX_rs, ID_EX_rt, EX_MEM_rd, MEM_WB_rd;

initial begin
    Operand1_MUX <= 2'b00;
    Operand2_MUX <= 2'b00;
end

always @*begin
		       
        /*Would be connected to a 3 to 1 MUX */
        /*operand 1 data*/
		if((EX_MEM_RegWrite == 1'b1) && (EX_MEM_rd != 5'b00000) && (EX_MEM_rd == ID_EX_rs)) begin
			Operand1_MUX = 2'b01;
		end else if((MEM_WB_RegWrite == 1'b1) && (MEM_WB_rd != 5'b00000) && (MEM_WB_rd == ID_EX_rs)) begin
			Operand1_MUX = 2'b10;   /*passes data loaded from memory - forwarded*/
        end else begin
            Operand1_MUX = 2'b00;   /*default case - passes normal rs data*/
        end
		
        /*Would be connected to a 3 to 1 MUX */
        /*operand 2 data*/
		if((EX_MEM_RegWrite == 1'b1) && (EX_MEM_rd != 5'b00000) && (EX_MEM_rd == ID_EX_rt)) begin
			Operand2_MUX = 2'b01;
		end else if((MEM_WB_RegWrite == 1'b1) && (MEM_WB_rd != 5'b00000) && (MEM_WB_rd == ID_EX_rt)) begin
			Operand2_MUX = 2'b10;   /*passes data loaded from memory - forwarded*/
        end else begin
            Operand2_MUX = 2'b00;   /*default case - passes normal rt data*/
        end
	end

	
endmodule
