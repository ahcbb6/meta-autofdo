# AutoFDO test class: "Proof of Concept using autotools"
# alejandro.hernandez@linux.intel.com
# victor.rodriguez.bahena@intel.com


# Flag to user before/after profiling
AUTOFDO_FLAG ?= "0"
#AUTOFDO_BIN ??= "${PN}"
#AUTOFDO_APP ??= "${PN}"

python () {
    # Create wrapper only when profiling, else compile with the right flags
    if d.getVar('AUTOFDO_FLAG', True) == "1":
        d.setVar('SRC_URI', d.getVar('SRC_URI', True) + " file://${AUTOFDO_APP}.gcov")
	bb.warn("Deploying")
	bb.warn(d.getVar('CFLAGS', True))
        d.setVar("CFLAGS", d.getVar('CFLAGS', True) + " -fauto-profile=${WORKDIR}/${AUTOFDO_APP}.gcov")
	bb.warn(d.getVar('CFLAGS', True))
}

