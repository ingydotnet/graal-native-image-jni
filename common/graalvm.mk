TEMP := /tmp

GRAALVM_NAME := graalvm-jdk-23_linux-x64_bin
GRAALVM_TAR := $(GRAALVM_NAME).tar.gz
GRAALVM_LINUX_X86_REPO := \
  https://download.oracle.com/graalvm/23/latest/$(GRAALVM_TAR)
GRAALVM_TAR := $(TEMP)/$(GRAALVM_TAR)
GRAALVM_HOME := $(TEMP)/graalvm-jdk-23.0.2+7.1
