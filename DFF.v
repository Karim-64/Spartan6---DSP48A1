module dff(d,q,clk,enable,rst);
    parameter WIDTH = 18;
    parameter RSTTYPE = "SYNC";
    input [WIDTH-1:0] d;
    input clk,enable,rst;
    output reg [WIDTH-1:0] q;
    generate
        if(RSTTYPE == "SYNC")
            always @(posedge clk) begin
                if(enable)
                    q <= (rst)? 0:d; 
            end
        else if(RSTTYPE == "ASYNC")
            always @(posedge clk or posedge rst) begin
                if(rst)
                    q <= 0;
                else if (enable)
                    q <= d;
            end
    endgenerate
endmodule