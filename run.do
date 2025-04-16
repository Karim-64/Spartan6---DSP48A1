vlib work 

vlog design.v testbench.v DFF.v mux2.v mux4.v 

vsim -voptargs=+acc work.DSP48A1_tb

add wave -position insertpoint  \
sim:/DSP48A1_tb/clk \
sim:/DSP48A1_tb/rsta \
sim:/DSP48A1_tb/a \
sim:/DSP48A1_tb/b \
sim:/DSP48A1_tb/c \
sim:/DSP48A1_tb/d \
sim:/DSP48A1_tb/opmode \
sim:/DSP48A1_tb/carryin \
sim:/DSP48A1_tb/bcin \
sim:/DSP48A1_tb/x \
sim:/DSP48A1_tb/z \
sim:/DSP48A1_tb/DUT/x_mux \
sim:/DSP48A1_tb/DUT/z_mux \
sim:/DSP48A1_tb/p_dut \
sim:/DSP48A1_tb/post_add_sub_exp \
sim:/DSP48A1_tb/bcout_dut \
sim:/DSP48A1_tb/bcout_exp \
sim:/DSP48A1_tb/carryout_dut \
sim:/DSP48A1_tb/carryoutf_dut \
sim:/DSP48A1_tb/cout_exp \
sim:/DSP48A1_tb/m_dut \
sim:/DSP48A1_tb/pcin \
sim:/DSP48A1_tb/pcout_dut \
sim:/DSP48A1_tb/DUT/m_mux  \
sim:/DSP48A1_tb/DUT/c_mux

run -all