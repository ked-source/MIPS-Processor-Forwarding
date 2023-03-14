module hazardDetection(HazardBit, PCWrite, IF_ID_write, ControlMuxBit, ID_EX_MemRead, ID_EX_rt, IF_ID_rs, IF_ID_rt);

    input wire [4:0] ID_EX_rt, IF_ID_rs, IF_ID_rt;
    input wire ID_EX_MemRead;
    output reg HazardBit, PCWrite, IF_ID_write, ControlMuxBit;

    /*If PC write signal is asserted then the PC increments normally. If it is deasserted it keeps on reading the same instruction over and over - needed for stalling
      If IF/ID write is deasserted, IF/ID register stays the same - used for stalling
    */

    initial begin
        PCWrite = 1'b1;
        IF_ID_write = 1'b1;
        HazardBit = 1'b0;
        ControlMuxBit = 1'b0; 
    end

    always @* begin
        if((ID_EX_MemRead == 1) && ((ID_EX_rt == IF_ID_rs)||(ID_EX_rt == IF_ID_rt))) begin      /*used to detect arithmetic operations after load memory instructions*/
            PCWrite <= 1'b0;
            IF_ID_write <= 1'b0;
            HazardBit <= 1'b1;
            ControlMuxBit <= 1'b1;      /*passes dummy signals (all control signals turned to 0) to next stage*/ 
        end else begin
            PCWrite <= 1'b1;
            IF_ID_write <= 1'b1;
            HazardBit <= 1'b0;
            ControlMuxBit <= 1'b0; 
        end
    end

endmodule