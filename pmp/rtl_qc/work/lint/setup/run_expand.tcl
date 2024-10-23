
source /data/usr/qijiahuan/pmp/rtl_qc/lint.tcl

fde::fde_write_file "/data/usr/qijiahuan/pmp/rtl_qc/work/lint/setup/run.tcl" [fde_expand -obj lint       -mode content -prefix {
package require fde
set FDE_PRINT_PIPE /data/usr/qijiahuan/pmp/rtl_qc/work/lint/.pipe/fde_print.pipe
puts "start to open $FDE_PRINT_PIPE"
set FDE_PRINT_FP [open $FDE_PRINT_PIPE {WRONLY NONBLOCK}]
puts "open success."
} -postfix {

    proc encode_array_from_py {arr_name} {
        global $arr_name
        set res ""
        foreach {key value} [array get $arr_name] {
            set res "$res%%%$key%%%%$value%%%%%
"
        }
        return $res 
    }

    set ARR [encode_array_from_py FDE_RUNTIME]
    set TIME_TABLE [fde::ffpy report_time_table.py $FDE_RUNTIME_SEQ $ARR]
    ffputs -type info "Time cost:
$TIME_TABLE"
    $setup(exit)
}]
