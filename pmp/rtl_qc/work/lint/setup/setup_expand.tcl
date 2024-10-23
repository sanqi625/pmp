
source /data/usr/qijiahuan/pmp/rtl_qc/lint.tcl

fde::fde_write_file "/data/usr/qijiahuan/pmp/rtl_qc/work/lint/setup/env.tcl" [fde_expand -obj lint.setup -mode content -prefix "" -postfix ""]
