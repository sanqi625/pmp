verdiSetActWin -dock widgetDock_<Decl._Tree>
simSetSimulator "-vcssv" -exec "/data/usr/qijiahuan/pmp/rtl_compile/simv" -args
debImport "-sv" "-f" "/data/usr/qijiahuan/pmp/rtl/filelist.f" "-dbdir" \
          "/data/usr/qijiahuan/pmp/rtl_compile/simv.daidir"
