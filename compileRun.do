vlog -work counter /home/delphifreak/Documents/projects-eclipse/tutorial/counter.v
vlog -work counter /home/delphifreak/Documents/projects-eclipse/tutorial/counterTest.v
vsim work.counterTest
add wave -position end  sim:/counterTest/bin
add wave -position end  sim:/counterTest/clk
add wave -position end  sim:/counterTest/reset_n
add wave -position end  sim:/counterTest/enable
add wave -position end  sim:/counterTest/match_value
add wave -position end  sim:/counterTest/oCounter
add wave -position end  sim:/counterTest/match
add wave -position end  sim:/counterTest/ovf
add wave -position end  sim:/counterTest/mode
add wave -position end  sim:/counterTest/up_n
add wave -position end  sim:/counterTest/ovf_mode