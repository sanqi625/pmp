all:comp sim
comp:
    vcs -sverilog -kdb +v2k -debug_access -full64 -timescale=1ns/1ns -l com.log -f filelist.f -R +WAVE

sim:
    ./simv -l sim.log +WAVE&


    SIM_FILELIST 		=/home/xuemengyuan/try/filelist.f

vcs -sverilog +v2k -debug_access -timescale=1ns/1ns -l com.log -f filelist.f -full64

./simv -l sim.log

verdi -sv -f filelist.f -ssf wave.fsdb -dbdir ./simv.daidir

vcs -kdb -full64 -debug_access -sverilog -f $(SIM_FILELIST) +lint=PCWM +lint=TFIPC-L +define+TOY_SIM
vcs -full64 -debug_access -sverilog -f /home/xuemengyuan/try/filelist.f +lint=PCWM +lint=TFIPC-L +define+macro=TOY_SIM
sim:
    ./simv -l sim.log +fsdbfile+top.fsdb &
verdi -sv -f filelist.f -ssf wave.fsdb -dbdir ./simv.daidir


	vcs -notice -debug_acc+all -j8 -timescale=1ns/1ps -sverilog -LDFLAGS -rdynamic -full64