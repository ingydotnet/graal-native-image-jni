SHELL := bash

EXAMPLES := $(wildcard example-*)
TESTS := $(EXAMPLES:example-%=test-%)
JAR_TESTS := $(EXAMPLES:example-%=test-jar-%)
NATIVE_TESTS := $(EXAMPLES:example-%=test-native-%)
CLEAN := $(EXAMPLES:example-%=clean-%)

MAKE := $(MAKE) --no-print-directory

include common/graalvm.mk


default:
	: $(CLEAN)

test: $(TESTS)

test-jar: $(JAR_TESTS)

test-native: $(NATIVE_TESTS)

clean: $(CLEAN)

sysclean: clean
	$(RM) $(GRAALVM_TAR)
	$(RM) -r $(GRAALVM_HOME)


test-%: example-%
	$(call line,$@)
	@$(MAKE) -C $< test

test-jar-%: example-%
	$(call line,$@)
	@$(MAKE) -C $< test-jar

test-native-%: example-%
	$(call line,$@)
	@$(MAKE) -C $< test-native

clean-%: example-%
	@$(MAKE) -C $< clean


define line
	@echo
	### $1 ----------------------------------------------------------------
	@echo

endef
