SUMMARY = "Set of tools to convert perf.data to AutoFDO profiles"
HOMEPAGE = "https://github.com/google/autofdo"


inherit autotools

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=3b83ef96387f14655fc854ddc3c6bd57"

PV = "0.0+git${SRCPV}"
SRCREV = "a50ddfb909506bf0df0bb680d9332afbd71e8c3e"

RDEPENDS_${PN} += "gcc libcrypto pmu-tools"

S="${WORKDIR}/git"

FILES_${PN} = "*"

SRC_URI = "git://github.com/google/autofdo"

# Install needs work ToDo
do_install(){
	
	install -d ${D}${bindir}

	install -m 777 create_gcov ${D}${bindir}/
	install -m 777 dump_gcov ${D}${bindir}/
	install -m 777 create_llvm_prof ${D}${bindir}/
	install -m 777 profile_diff ${D}${bindir}/
	install -m 777 profile_merger ${D}${bindir}/
	install -m 777 profile_update ${D}${bindir}/
	install -m 777 sample_merger ${D}${bindir}/
}
