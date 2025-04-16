module DSP48A1 #(
    parameter A0REG         = 0,
    parameter A1REG         = 1,
    parameter B0REG         = 0,
    parameter B1REG         = 1,
    ////////////////////////////
    parameter CREG          = 1,
    parameter DREG          = 1,
    parameter MREG          = 1,
    parameter PREG          = 1,
    parameter CARRYINREG    = 1,
    parameter CARRYOUTREG   = 1,
    parameter OPMODEREG     = 1,
    ///////////////////////////////////
    parameter CARRYINSEL    ="OPMODE5",
    ///////////////////////////////////
    parameter B_INPUT       ="DIRECT",
    ///////////////////////////////////
    parameter RSTTYPE       ="SYNC"
)(
    input [17:0] a,b,d,bcin,
    input [47:0] c,pcin,
    input [7:0] opmode,
    input rsta,rstb,rstm,rstp,rstc,rstd,rstcarryin,rstopmode,
    cea,ceb,cem,cep,cec,ced,cecarryin,ceopmode,clk,carryin,
    output [17:0] bcout,
    output [47:0] pcout,p,
    output [35:0] m,
    output carryout,carryoutf
);

    //opmode
    wire [7:0] opmode_mux,opmode_reg;
    dff  #(.WIDTH(8),.RSTTYPE(RSTTYPE)) OPMODE_REG(opmode,opmode_reg,clk,ceopmode,rstopmode);
    mux2 #(.WIDTH(8)) op_mux(opmode_reg,opmode,OPMODEREG,opmode_mux);

    //d block 
    wire [17:0] d_reg,d_mux;
    dff  #(.WIDTH(18),.RSTTYPE(RSTTYPE)) D_REG (d,d_reg,clk,ced,rstd);
    mux2 #(.WIDTH(18)) m1(d_reg,d,DREG,d_mux);

    //b block
    wire [17:0] b0_reg,bin_mux,b0_mux;
    assign bin_mux = (B_INPUT == "DIRECT")? b : (B_INPUT =="CASCADE")? bcin : 0;
    dff  #(.WIDTH(18),.RSTTYPE(RSTTYPE)) B0_REG (bin_mux,b0_reg,clk,ceb,rstb);
    mux2 #(.WIDTH(18)) m2(b0_reg,bin_mux,B0REG,b0_mux);

    //a block 
    wire [17:0] a0_reg,a0_mux;
    dff  #(.WIDTH(18),.RSTTYPE(RSTTYPE)) A0_REG (a,a0_reg,clk,cea,rsta);
    mux2 #(.WIDTH(18)) m3(a0_reg,a,A0REG,a0_mux);

    //c block
    wire [47:0] c_reg,c_mux;
    dff  #(.WIDTH(48),.RSTTYPE(RSTTYPE)) C_REG (c,c_reg,clk,cec,rstc);
    mux2 #(.WIDTH(48)) m4(c_reg,c,CREG,c_mux);

    //pre_adder/subtractor and b1 regester
    wire [17:0] padd_sub,padd_sub_mux,b1_reg,b1_mux,padd,psub;
    assign padd = d_mux + b0_mux;
    assign psub = d_mux - b0_mux;
    assign padd_sub = (opmode_mux[6])? psub : padd;
    mux2 #(.WIDTH(18)) m5(padd_sub,b0_mux,opmode_mux[4],padd_sub_mux);
    dff  #(.WIDTH(18),.RSTTYPE(RSTTYPE)) B1_REG (padd_sub_mux,b1_reg,clk,ceb,rstb);   
    mux2 #(.WIDTH(18)) m6(b1_reg,padd_sub_mux,B1REG,b1_mux);   
    assign bcout = b1_mux;

    //a1 regester
    wire [17:0] a1_reg,a1_mux;
    dff  #(.WIDTH(18),.RSTTYPE(RSTTYPE)) A1_REG (a0_mux,a1_reg,clk,cea,rsta);
    mux2 #(.WIDTH(18)) m7(a1_reg,a0_mux,A1REG,a1_mux);

    //multiplication block
    wire [35:0] m_res,m_reg,m_mux;
    assign m_res = a1_mux*b1_mux;
    dff  #(.WIDTH(36),.RSTTYPE(RSTTYPE)) M_REG (m_res,m_reg,clk,cem,rstm);   
    mux2 #(.WIDTH(36)) m8(m_reg,m_res,MREG,m_mux);
    assign m = (~(~m_mux)); 

    //mux x 
    wire [47:0] x_mux;
    mux4 #(.WIDTH(48)) m9(48'b0,{12'b0,m_mux},p,{d_mux[11:0],a[17:0],b[17:0]},opmode_mux[1:0],x_mux);

    //mux z
    wire [47:0] z_mux;
    mux4 #(.WIDTH(48)) m10(48'b0,pcin,p,c_mux,opmode_mux[3:2],z_mux);

    //carry in 
    wire cin0_mux,cin_reg,cin1_mux;
    assign cin0_mux = (CARRYINSEL == "OPMODE5")? opmode_mux[5] : (CARRYINSEL == "CARRYIN")? carryin : 0;
    dff #(.WIDTH(1),.RSTTYPE(RSTTYPE)) CYI(cin0_mux,cin_reg,clk,cecarryin,rstcarryin);
    mux2 #(.WIDTH(1)) m11(cin_reg,cin0_mux,CARRYINREG,cin1_mux);

    //post adder
    wire [47:0] post_add_sub,post_add_sub_reg,post_add_sub_mux,post_add,post_sub;
    wire cout,cout_add,cout_sub;
    assign {cout_add,post_add} = z_mux+x_mux+{47'b0,cin1_mux};
    assign {cout_sub,post_sub} = z_mux-x_mux-{47'b0,cin1_mux};
    assign {cout,post_add_sub}= (opmode_mux[7])? {cout_sub,post_sub} : {cout_add,post_add};
    dff #(.WIDTH(48),.RSTTYPE(RSTTYPE)) P_REG(post_add_sub,post_add_sub_reg,clk,cep,rstp);
    mux2 #(.WIDTH(48)) m12(post_add_sub_reg,post_add_sub,PREG,post_add_sub_mux);
    assign p     = post_add_sub_mux;
    assign pcout = post_add_sub_mux;

    //carryout mux
    wire cout_reg,cout_mux;
    dff #(.WIDTH(1),.RSTTYPE(RSTTYPE)) CYO(cout,cout_reg,clk,cecarryin,rstcarryin);
    mux2 #(.WIDTH(1)) m13(cout_reg,cout,CARRYOUTREG,cout_mux);
    assign carryout  = cout_mux;
    assign carryoutf = cout_mux;
endmodule