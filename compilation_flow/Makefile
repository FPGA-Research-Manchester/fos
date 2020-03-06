# Makefile to build hls and rtl modules into pr modules
.DEFAULT_GOAL := all


# Hahaha what am i doing

# HLS -> RTL synthesis
HLS_DIR   := hls
HLSC      := python3 -u $(HLS_DIR)/autohls.py
HLSCFLAGS :=
HLSC_OUT  := $(HLS_DIR)
HLSC_CHIP := xczu3eg-sbva484-1-e
HLS_SRC   := ../module_src/hls

# RTL -> Module synthesis
PR_DIR    := pr_flow
PRC       := python3 -u $(PR_DIR)/automodule.py
PRCFLAGS  := --loud
PRC_OUT   := $(PR_DIR)/output

# HLS Sources
HLS_SOURCES     := BLEURO SHREK MANDEL MANDEL128 SOBEL VADD32 VADD128
HLS_BLEURO_SRC  := barrierData.h  blackEuro.cpp  blackScholes.h  europeanOption.h  launchSim.h  RNG.h  stockData.h  volatilityData.h
HLS_BLEURO      := $(addprefix $(HLS_SRC)/blackeuro/, $(HLS_BLEURO_SRC))
HLS_BLEURO_TOP  := blackEuro

HLS_SHREK       := $(HLS_SRC)/shrek/shrek2.c
HLS_SHREK_TOP   := shrek

HLS_MANDEL      := $(addprefix $(HLS_SRC)/mandel/, mandelbrot.c mandelbrot.h)
HLS_MANDEL_TOP  := mandelbrot

HLS_MANDEL128      := $(addprefix $(HLS_SRC)/mandel128/, mandelbrot.c mandelbrot.h)
HLS_MANDEL128_TOP  := mandelbrot128

HLS_SOBEL       := $(addprefix $(HLS_SRC)/sobel/, edge.h krnl_sobelfilter.cl)
HLS_SOBEL_TOP   := sobel

HLS_VADD32      := $(HLS_SRC)/vadd/vadd.cl
HLS_VADD32_TOP  := vadd

HLS_VADD128     := $(HLS_SRC)/vadd128/vadd128.cl
HLS_VADD128_TOP := vadd128

# RTL Sources
RTL_SOURCES   := $(HLS_SOURCES)
$(foreach source, $(RTL_SOURCES), $(eval \
	RTL_$(source) := $(HLSC_OUT)/output/$$(HLS_$(source)_TOP)/$$(HLS_$(source)_TOP)/$$(HLS_$(source)_TOP)_data.json \
))
#RTL_BLEURO    = $(HLSC_OUT)/blackEuro/blackEuro/blackEuro_data.json
#RTL_SHREK     = $(HLSC_OUT)/shrek/shrek/shrek_data.json
#RTL_MANDEL    = $(HLSC_OUT)/mandelbrot/mandelbrot/mandelbrot_data.json
#RTL_MANDEL128 = $(HLSC_OUT)/mandelbrot128/mandelbrot128/mandelbrot128_data.json
#RTL_SOBEL     = $(HLSC_OUT)/sobel/sobel/sobel_data.json
#RTL_VADD32    = $(HLSC_OUT)/vadd/vadd/vadd_data.json
#RTL_VADD128   = $(HLSC_OUT)/vadd128/vadd128/vadd128_data.json


# PR Shells
SHELL_U96_32  := u96_32
SHELL_U96_128 := u96_128
SHELL_ZCU_32  := zucl_stc

# defines to generate rules
define ADD_HLS_RULES # creates rule to make rtl from c/c++/cl sources
RTL_TARGETS += $$(RTL_$1)
$$(RTL_$1): $$(HLS_$1)
	-rm -rf $(HLSC_OUT)/$$(HLS_$1_TOP)
	$(HLSC) $$(HLS_$1_TOP) $$(HLS_$1_TOP) $$(HLS_$1_TOP) $(HLSC_CHIP) $$(HLS_$1) $(HLSCFLAGS) | sed -e 's/^/[rtl:$1] /'
endef

define ADD_RTL_RULES # creates rule to make module from rtl
PR_$1_$2 := $(PRC_OUT)/$(HLS_$1_TOP)/$(SHELL_$2)/Partial_$(HLS_$1_TOP).json
PR_TARGETS += $$(PR_$1_$2)
$$(PR_$1_$2): $$(RTL_$1)
	$(PRC) $$(RTL_$1) $$(SHELL_$2) $(PRCFLAGS) | sed -e 's/^/[rtl:$1:$2] /'
endef

# build rules for all hls sources
$(foreach source, $(HLS_SOURCES), $(eval $(call ADD_HLS_RULES,$(source))))

# build rules for all rtl sources
$(eval $(call ADD_RTL_RULES,BLEURO,U96_32))
$(eval $(call ADD_RTL_RULES,BLEURO,ZCU_32))

$(eval $(call ADD_RTL_RULES,SHREK,U96_32))
$(eval $(call ADD_RTL_RULES,SHREK,ZCU_32))

$(eval $(call ADD_RTL_RULES,MANDEL,U96_32))
$(eval $(call ADD_RTL_RULES,MANDEL,ZCU_32))

$(eval $(call ADD_RTL_RULES,MANDEL128,U96_128))

$(eval $(call ADD_RTL_RULES,SOBEL,U96_32))
$(eval $(call ADD_RTL_RULES,SOBEL,ZCU_32))

$(eval $(call ADD_RTL_RULES,VADD32,U96_32))
$(eval $(call ADD_RTL_RULES,VADD32,ZCU_32))

$(eval $(call ADD_RTL_RULES,VADD128,U96_128))

# echo info about targets
$(info (All RTL Targets: $(RTL_TARGETS)))
$(info (All PR Targets: $(PR_TARGETS)))

# default behaviour is build-all rule
all: $(RTL_TARGETS) $(PR_TARGETS)

