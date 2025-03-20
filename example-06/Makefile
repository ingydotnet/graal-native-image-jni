SHELL := bash

BASE := $(shell pwd -P)

TEMP := /tmp

GRAALVM_NAME := graalvm-jdk-23_linux-x64_bin
GRAALVM_TAR := $(GRAALVM_NAME).tar.gz
GRAALVM_LINUX_X86_REPO := \
  https://download.oracle.com/graalvm/23/latest/$(GRAALVM_TAR)
GRAALVM_TAR := $(TEMP)/$(GRAALVM_TAR)
GRAALVM_HOME := $(TEMP)/graalvm-jdk-23.0.2+7.1

export JAVA_HOME := $(GRAALVM_HOME)
export PATH := $(BASE):$(JAVA_HOME)/bin:$(PATH)

NAME := HelloWorld
name := $(shell echo $(NAME) | tr A-Z a-z)
NATIVE := $(name)
JAR  := $(NAME).jar
VER  := 1.2.3
LIB  := lib/lib$(name).$(VER).so

H_FILE := net_ingy_HelloWorld.h
JAVA_FILES := $(shell find src	-name '*.java')
CLASS_FILES := $(JAVA_FILES:%.java=%.class)
MANIFEST_FILE := src/manifest.txt


default:
	@(IFS=:; printf '%s\n' $$PATH)

test: build test-jar test-native

build: $(NATIVE)
	@:

test-jar: $(JAR)
	@echo '*** Testing $@'
	java -jar $<
	@echo

test-native: $(NATIVE)
	@echo '*** Testing $@'
	$<
	@echo

clean:
	$(RM) $(CLASS_FILES) src/*.h $(JAR) $(LIB) $(NATIVE)
	$(RM) helloworld-build-report.html
	$(RM) -r reports bin lib target

sysclean: clean
	$(RM) $(GRAALVM_TAR)
	$(RM) -r $(GRAALVM_HOME)

$(NATIVE): $(JAR)
	native-image $(NATIVE_OPTS) -Ob -jar $< -o $@

$(JAR):: $(CLASS_FILES) $(LIB)
	jar cfm $@ $(MANIFEST_FILE) \
	  -C src net/ingy/$(NAME).class \
	  -C src net/ingy/NativeLoader.class
	jar uf $@ -C lib libhelloworld.1.2.3.so

src/%.class: src/%.java $(GRAALVM_HOME)
	javac -cp src $<

$(LIB): src/$(NAME).c src/$(H_FILE)
	mkdir -p lib
	gcc -shared -Wall -Werror \
		-I$(JAVA_HOME)/include \
		-I$(JAVA_HOME)/include/linux \
		-o $@ \
		-fPIC \
		$<

src/$(H_FILE): src/net/ingy/$(NAME).java
	cd src && javac -h $(BASE)/src $(<:src/%=%)

$(GRAALVM_HOME): $(GRAALVM_TAR)
	tar -C $(TEMP) -xf $<
	touch $@

$(GRAALVM_TAR):
	curl -sSL -o $@ $(GRAALVM_LINUX_X86_REPO)
	touch $@


NAME := HelloWorld

NATIVE_OPTS := \
  -H:ResourceConfigurationFiles=resources.json \


run-jar: $(JAR)
	java -jar $<



#   --emit=build-report \
#   -H:ResourceConfigurationFiles=resources2.json \
#   -H:Log=registerResource: \
#   -H:IncludeResources=.*[hH]ello.* \
#   -H:IncludeResources=lib/libhelloworld.1.2.3.so \
#   -H:ResourceConfigurationFiles=resources.json \
