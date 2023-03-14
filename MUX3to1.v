module MUX3to1
#(parameter WIDTH = 32)
(flag, in1, in2, in3, out);

input wire [1:0] flag;
input wire [WIDTH-1:0] in1;
input wire [WIDTH-1:0] in2;
input wire [WIDTH-1:0] in3;

output reg [WIDTH-1:0] out;

always @* begin
    case(flag)
      2'b00: begin
          out <= in1;
      end
      2'b01: begin
          out <= in2;
      end
      2'b10: begin
          out <= in3;
      end
    endcase
end

endmodule
