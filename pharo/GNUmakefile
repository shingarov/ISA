PROJECT=ISA

all: build

../makefiles/%.gmk:
	git submodule update --init --recursive $(dir $@)

-include GNUmakefile.local
include ../makefiles/pharo.gmk
include ../makefiles/git.gmk

ifndef MACHINEARITHMETIC_DIR
MACHINEARITHMETIC_DIR    := ../3rdparty/MachineArithmetic
MACHINEARITHMETIC_URL    ?= https://github.com/shingarov/MachineArithmetic
MACHINEARITHMETIC_BRANCH ?= pure-z3
$(eval $(call git-clone-local,MACHINEARITHMETIC_DIR,$(MACHINEARITHMETIC_URL),$(MACHINEARITHMETIC_BRANCH)))
endif

build: prereq $(PROJECT).image
	@echo ""
	@echo "To open Pharo $(PROJECT) image run:"
	@echo ""
	@echo "    make run"
	@echo ""

$(PROJECT).image: ../src/*/*.st
	$(call pharo-copy-image, $(PHARO_IMAGE), $@)
	$(call pharo-load-local, $@, MachineArithmetic,$(MACHINEARITHMETIC_DIR)/src)
	$(call pharo-load-local, $@, ISA,            ../src)

run: build
	$(PHARO_VM) $(PROJECT).image

test: build
	 $(PHARO_VM_HEADLESS) $(PROJECT).image test --fail-on-failure \
		"Sail-Jib-Tests"

clean::
	rm -f $(PROJECT).image $(PROJECT).changes

mrproper:: clean

.PHONY: all build run test clean mrproper
