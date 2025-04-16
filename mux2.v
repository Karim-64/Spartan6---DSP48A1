module mux2 (a,b,sel,out);
    parameter WIDTH = 18 ;
    input [WIDTH-1:0] a,b;
    input sel;
    output [WIDTH-1:0] out;
    assign out = (sel)? a:b;
endmodule