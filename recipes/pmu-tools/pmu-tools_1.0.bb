SUMMARY = "Toolkit to procide various Intel speicific profiling functionality on top of perf"
HOMEPAGE = "https://github.com/andikleen/pmu-tools"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f"

PV = "0.0+git${SRCPV}"
SRCREV = "f07d87dd9cb252892a9fa11e55b8822f5e18ec79"

RDEPENDS_${PN} += "bash python-core python-subprocess python-json python-shell perf"

S="${WORKDIR}/git"

FILES_${PN} = "*"

SRC_URI = "git://github.com/andikleen/pmu-tools"


# Needs more work, specially the links
do_install(){

	install -d ${D}/opt/pmu-tools
	install -d ${D}/opt/pmu-tools/jevents
	install -d ${D}/opt/pmu-tools/parser
	install -d ${D}/opt/pmu-tools/pebs-grabber
	install -d ${D}/opt/pmu-tools/simple-pebs
	install -d ${D}/opt/pmu-tools/ucevent

	cp -R * ${D}/opt/pmu-tools/

	install -d ${D}${bindir}
	ln -s /opt/pmu-tools/ocperf.py ${D}${bindir}/ocperf
}
