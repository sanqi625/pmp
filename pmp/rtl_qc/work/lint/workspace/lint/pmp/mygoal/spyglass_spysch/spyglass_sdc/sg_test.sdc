# set CLK_PERIOD 10
# create_clock -name clk -period $CLK_PERIOD [get_ports clk]
# set_false_path -from [get_ports rst_n]
# set_input_delay [expr $CLK_PERIOD*0.6] -clock clk [remove_from_collection [all_inputs] clk]
