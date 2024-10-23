

source $env(FDE_HOME)/demo/lint/lint.tcl

fde_add -obj lint.user_config -name user_config -position on {
    set design(top_name)    "pmp"
    set design(filelist)    "/data/usr/qijiahuan/pmp/rtl/filelist.f"
    set lint(waiver)        "/data/usr/qijiahuan/pmp/rtl_qc/lint.awl"
}
