proc regdump {msg} {
    puts "======================================================================"
    puts "==  $msg"
	
    set value [mrd -force 0xFFCA0044]
    puts -nonewline "    PS_VERSION                      = $value"
	
    set value [mrd -force 0xFF5E0200]
    puts -nonewline "    BOOT_MODE_USER                  = $value"
	
    set value [mrd -force 0xFF5E0204]
    puts -nonewline "    BOOT_MODE_POR                   = $value"
	
    set value [mrd -force 0xFF5E0220]
    puts -nonewline "    RESET_REASON                    = $value"

    set value [mrd -force 0xFFD80100]
    puts -nonewline "    PMU_GLOBAL.PWR_STATE            = $value"

    set value [mrd -force 0xFFD8010C]
    puts -nonewline "    PWR_SUPPLY_STATUS               = $value"

    set value [mrd -force 0xFFD80528]
    puts -nonewline "    CSU_BR_ERROR                    = $value"

    set value [mrd -force 0xFFD80530]
    puts -nonewline "    ERROR_STATUS_1                  = $value"

    set value [mrd -force 0xFFD80540]
    puts -nonewline "    ERROR_STATUS_2                  = $value"

    set value [mrd -force 0xFFCA0000]
    puts -nonewline "    csu_status                      = $value"

    set value [mrd -force 0xFFCA0018]
    puts -nonewline "    csu_ft_status                   = $value"

    set value [mrd -force 0xFFCA0020]
    puts -nonewline "    CSU_ISR                         = $value"

    set value [mrd -force 0xFFCA3010]
    puts -nonewline "    pcap_status                     = $value"

    set value [mrd -force 0xFFCA5000]
    puts -nonewline "    tamper_status                   = $value"

    set value [mrd -force 0xFFCA0034]
    puts -nonewline "    jtag_chain_status               = $value"

    set value [mrd -force 0xFFCA0038]
    puts -nonewline "    jtag_sec                        = $value"

    puts [targets]
}
connect
targets -set -filter {name =~ "PSU" || name =~ "PS8"}
mwr 0xffca0038 0x1FF
targets -set -filter {name =~ "MicroBlaze PMU"}
exec sleep.exe 1
regdump "Registers Dump"
puts [fpga -config-status]
disconnect

