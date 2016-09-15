SUMMARY = "Bubble Sort test recipe to be implemented using AutoFDO"

inherit autotools autofdo-profile

LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

S = "${WORKDIR}/build"

SRC_URI = "file://bubble.tar.xz"

FILES_${PN} += "${bindir}/bubble"

do_configure_preppend() {
	cp ${S}/* ${WORKDIR}/build/
}

do_install () {
	install -d ${D}${bindir}
	install -m 777 bubble ${D}${bindir}/bubble
}
