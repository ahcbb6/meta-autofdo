# AutoFDO test class: "Proof of Concept using autotools"
# alejandro.hernandez@linux.intel.com
# victor.rodriguez.bahena@intel.com


RDEPENDS_${PN}_append = " perf pmu-tools autofdo"

# Flag to user before/after profiling
AUTOFDO_FLAG ?= "0"

do_create_wrapper () {
	cat > ${D}${bindir}/autofdo_${PN} << EOF
#!/bin/sh
echo "Profiling application..."
ocperf record -b -e br_inst_retired.near_taken -- ${bindir}/${PN}
create_gcov --binary=${bindir}/${PN} --profile=perf.data --gcov=${PN}.gcov -gcov_version=1
echo "You can now use ${PN}.gcov to optimize ${PN}"
EOF
	chmod 777 ${D}${bindir}/autofdo_${PN}
}


python () {
    # Create wrapper only when profiling, else compile with the right flags
    if d.getVar('AUTOFDO_FLAG', True) == "0":
        d.setVar(d.getVar(d.expand('FILES_${PN}'), True), " ${bindir}/autofdo_${PN}") 
	bb.warn("Profiling")
        bb.build.addtask('do_create_wrapper', 'do_package', 'do_install', d)
    elif d.getVar('AUTOFDO_FLAG', True) == "1":
        d.setVar('SRC_URI', d.getVar('SRC_URI', True) + " file://${PN}.gcov")
	bb.warn("Deploying")
        d.setVar('EXTRA_OEMAKE_${PN}', 'CFLAGS=-O3 -fauto-profile=${PN}.gcov')
}

