SHELL := bash

ROOT ?= $(shell cd -P .. && pwd -P)
BASE := $(shell pwd -P)
COMMON ?= $(ROOT)/common

include $(COMMON)/graalvm.mk

export JAVA_HOME := $(GRAALVM_HOME)
export PATH := $(BASE):$(JAVA_HOME)/bin:$(PATH)
export LD_LIBRARY_PATH := $(BASE)/lib
