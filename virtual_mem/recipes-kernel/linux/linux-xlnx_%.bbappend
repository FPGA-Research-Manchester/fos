SRC_URI += "file://bsp.cfg \
            file://user_2018-08-24-17-14-00.cfg \
	    file://0001-flush_poc.patch \
	    "

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
