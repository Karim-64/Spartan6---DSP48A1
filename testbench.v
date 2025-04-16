module DSP48A1_tb ();
  parameter A0REG = 0;
  parameter A1REG = 1;
  parameter B0REG = 0;
  parameter B1REG = 1;
  parameter CREG = 1;
  parameter DREG = 1;
  parameter MREG = 1;
  parameter PREG = 1;
  parameter CARRYINREG = 1;
  parameter CARRYOUTREG = 1;
  parameter OPMODEREG = 1;
  parameter CARRYINSEL = "OPMODE5";
  parameter B_INPUT = "DIRECT";
  parameter RSTTYPE = "SYNC";
  reg [17:0] a, b, d, bcin;
  reg [47:0] c, pcin;
  reg [7:0] opmode;
  reg
      rsta,
      rstb,
      rstm,
      rstp,
      rstc,
      rstd,
      rstcarryin,
      rstopmode,
      cea,
      ceb,
      cem,
      cep,
      ccec,
      ced,
      cecarryin,
      ceopmode,
      clk,
      carryin;
  wire [17:0] bcout_dut;
  wire [47:0] pcout_dut, p_dut;
  wire [35:0] m_dut;
  wire carryout_dut, carryoutf_dut;

  //module instantiation
  DSP48A1 #(
      .A0REG(A0REG),
      .A1REG(A1REG),
      .B0REG(B0REG),
      .B1REG(B1REG),
      .CREG(CREG),
      .DREG(DREG),
      .MREG(MREG),
      .PREG(PREG),
      .CARRYINREG(CARRYINREG),
      .CARRYOUTREG(CARRYOUTREG),
      .OPMODEREG(OPMODEREG),
      .CARRYINSEL(CARRYINSEL),
      .B_INPUT(B_INPUT),
      .RSTTYPE(RSTTYPE)
  ) DUT (
      .a(a),
      .b(b),
      .c(c),
      .d(d),
      .pcin(pcin),
      .bcin(bcin),
      .opmode(opmode),
      .rsta(rsta),
      .rstb(rstb),
      .rstc(rstc),
      .rstd(rstd),
      .rstm(rstm),
      .rstp(rstp),
      .rstcarryin(rstcarryin),
      .rstopmode(rstopmode),
      .cea(cea),
      .ceb(ceb),
      .cem(cem),
      .cep(cep),
      .ccec(ccec),
      .ced(ced),
      .cecarryin(cecarryin),
      .ceopmode(ceopmode),
      .clk(clk),
      .carryin(carryin),
      .bcout(bcout_dut),
      .pcout(pcout_dut),
      .p(p_dut),
      .m(m_dut),
      .carryout(carryout_dut),
      .carryoutf(carryoutf_dut)
  );
  reg [47:0] x, z, post_add_sub_exp, post_add, post_sub;
  reg [35:0] m_exp;
  reg [17:0] bcout_exp;
  reg cout_exp;
  reg [47:0] pout_temp;

  initial begin
    clk = 0;
    forever #1 clk = ~clk;
  end

  //test generator
  initial begin
    cea        = 1;
    ceb        = 1;
    cem        = 1;
    cep        = 1;
    ccec       = 1;
    ced        = 1;
    cecarryin  = 1;
    ceopmode   = 1;
    rsta       = 1;
    rstb       = 1;
    rstc       = 1;
    rstd       = 1;
    rstm       = 1;
    rstp       = 1;
    rstcarryin = 1;
    rstopmode  = 1;
    @(negedge clk);
    rsta       = 0;
    rstb       = 0;
    rstc       = 0;
    rstd       = 0;
    rstm       = 0;
    rstp       = 0;
    rstcarryin = 0;
    rstopmode  = 0;
    repeat (1000) begin
      a       = $random;
      b       = $random;
      c       = $random;
      d       = $random;
      carryin = $random;  // opmode[5] should take its turn as CARRYINSEL = "OPMODE5"
      pcin    = $random;
      opmode  = $random;
      if (opmode[3:2] == 2) opmode[3:2] = 3;
      if (opmode[1:0] == 2) opmode[1:0] = 3;
      bcout_exp = (opmode[6]) ? (d - b) : (d + b);
      bcout_exp = (opmode[4]) ? bcout_exp : b;
      m_exp = a * bcout_exp;
      case (opmode[1:0])
        2'b00: x = 48'b0;
        2'b01: x = m_exp;
        2'b10: x = p_dut;
        2'b11: x = {d[11:0], a[17:0], b[17:0]};
      endcase
      case (opmode[3:2])
        2'b00: z = 48'b0;
        2'b01: z = pcin;
        2'b10: z = p_dut;
        2'b11: z = c;
      endcase
      post_add = z + x + {47'b0, opmode[5]};
      post_sub = z - x - {47'b0, opmode[5]};
      {cout_exp,post_add_sub_exp} = (opmode[7])? z-x-{47'b0,opmode[5]} : z+x+{47'b0,opmode[5]};
      repeat (4) @(negedge clk);
      if (bcout_dut != bcout_exp) begin
          $display("Error in bcout value");
          $stop;
      end
      if (m_dut != m_exp) begin
          $display("Error in the multiplier output");
          $stop;
      end
      if (p_dut != post_add_sub_exp || pcout_dut != p_dut) begin
          $display("Error in the p output");
          $stop;
      end
      if (carryout_dut != cout_exp || carryout_dut != carryoutf_dut) begin
          $display("Error in the carryout output");
          $stop;
      end
      end
    $display("the DSP passed the opmodes 0,1,3");
    rsta       = 1;
    rstb       = 1;
    rstc       = 1;
    rstd       = 1;
    rstm       = 1;
    rstp       = 1;
    rstcarryin = 1;
    rstopmode  = 1;
    @(negedge clk);
    rsta        = 0;
    rstb        = 0;
    rstc        = 0;
    rstd        = 0;
    rstm        = 0;
    rstp        = 0;
    rstcarryin  = 0;
    rstopmode   = 0;
    c           = 50;
    opmode[1:0] = 0;
    opmode[3:2] = 3;
    opmode[5]   = 0;
    opmode[7]   = 0;
    repeat (2) @(negedge clk);
    if (p_dut != 50) begin
      $display("Error in opmode 3");
      $stop;
    end
    pout_temp   = p_dut;
    opmode[1:0] = 2;
    opmode[3:2] = 2;
    repeat (2) @(negedge clk);
    $display("the DSP passed the tests");
    $stop;
  end
endmodule
