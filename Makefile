SHELL := bash

ROOT=$(shell pwd)

export JAVA_HOME := $(GRAALVM)
export PATH := $(ROOT):$(JAVA_HOME)/bin:$(PATH)
export LD_LIBRARY_PATH := $(ROOT)


test: build test-jar test-native

build: helloworld libHelloWorld.so
	@echo

test-jar: HelloWorld.jar libHelloWorld.so
	@echo '*** Testing $@'
	java -jar $<
	@echo

test-native: helloworld libHelloWorld.so
	@echo '*** Testing $@'
	$<
	@echo

clean:
	$(RM) src/*.class
	$(RM) src/*.h
	$(RM) *.jar
	$(RM) *.so
	$(RM) helloworld
	$(RM) -r reports


helloworld: HelloWorld.jar
	$(GRAALVM)/bin/native-image \
		-jar $< \
		-H:Name=$@ \
		--verbose \
		--no-fallback \
		--no-server \
		"-J-Xmx1g" \
		--initialize-at-build-time \
		-H:+ReportExceptionStackTraces \
		-H:ConfigurationFileDirectories=config-dir \
		-H:+PrintClassInitialization

HelloWorld.jar: src/HelloWorld.class src/manifest.txt
	cd src && jar cfm ../HelloWorld.jar manifest.txt HelloWorld.class

src/HelloWorld.class: src/HelloWorld.java
	javac $<

libHelloWorld.so: src/HelloWorld.h src/HelloWorld.c
	gcc -shared -Wall -Werror \
		-I$(JAVA_HOME)/include \
		-I$(JAVA_HOME)/include/linux \
		-o libHelloWorld.so \
		-fPIC \
		src/HelloWorld.c

src/HelloWorld.h: src/HelloWorld.java
	cd src && javac -h $(PWD)/src HelloWorld.java
