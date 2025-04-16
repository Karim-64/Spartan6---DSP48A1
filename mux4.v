module mux4(a,b,c,d,sel,out);
    parameter WIDTH = 18 ;
    input [WIDTH-1:0] a,b,c,d;
    input [1:0] sel;
    output reg [WIDTH-1:0] out;
    always @(*) begin
        case(sel)
            0: out = a;
            1: out = b;
            2: out = c;
            3: out = d;
        endcase
    end
endmodule