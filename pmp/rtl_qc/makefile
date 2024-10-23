RTL_COMPILE_OUTPUT 	= /data/usr/qijiahuan/pmp/rtl_compile
SIM_FILELIST        = /data/usr/qijiahuan/pmp/rtl/filelist.f
.PHONY: compile lint

compile:
	mkdir -p $(RTL_COMPILE_OUTPUT)
	cd $(RTL_COMPILE_OUTPUT) ;vcs -kdb -full64 -debug_access -sverilog -f $(SIM_FILELIST) +lint=PCWM +lint=TFIPC-L +define+TOY_SIM

# wsl compile
comp:
	mkdir -p $(RTL_COMPILE_OUTPUT)
	cd $(RTL_COMPILE_OUTPUT) ;vcs -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -kdb -lca -full64 -debug_access -sverilog -f $(SIM_FILELIST) +lint=PCWM +lint=TFIPC-L +define+TOY_SIM

lint:
	fde -file /data/usr/qijiahuan/pmp/rtl_qc/lint.tcl -flow lint

verdi:
	verdi -sv -f $(SIM_FILELIST) -ssf wave.fsdb -dbdir $(RTL_COMPILE_OUTPUT)/simv.daidir