# AutoFDO test class: "Proof of Concept using autotools"
# alejandro.hernandez@linux.intel.com
# victor.rodriguez.bahena@intel.com


RDEPENDS_${PN}_append = " perf pmu-tools autofdo"

AUTOFDO_BIN ?= "${PN}"
AUTOFDO_APP ?= "${PN}"

do_create_wrapper () {
	cat > ${D}${bindir}/autofdo_${AUTOFDO_APP} << EOF
#!/bin/sh
echo "Profiling application..."
#ocperf record -b -e br_inst_retired.near_taken -- ${bindir}/${PN}
ocperf record -b -e cpu/event=0xc4,umask=0x20,name=br_inst_retired_near_taken,period=400009/pp -- ${bindir}/${AUTOFDO_APP}
create_gcov --binary=${bindir}/${AUTOFDO_BIN} --profile=perf.data --gcov=${AUTOFDO_APP}.gcov -gcov_version=1
echo "You can now use ${AUTOFDO_APP}.gcov to optimize ${PN}"
EOF
	chmod 777 ${D}${bindir}/autofdo_${AUTOFDO_APP}
}


python () {
    # Create wrapper for AUTOFDO_BIN only when profiling
    if d.getVar('AUTOFDO_FLAG', True) == "0":
        d.setVar(d.getVar(d.expand('FILES_${PN}'), True), " ${bindir}/autofdo_${AUTOFDO_APP}") 
	bb.warn("Profiling")
        bb.build.addtask('do_create_wrapper', 'do_package', 'do_install', d)
    elif d.getVar('AUTOFDO_FLAG', True) == "1":
	bb.build.deltask('do_create_wrapper', d)
}

