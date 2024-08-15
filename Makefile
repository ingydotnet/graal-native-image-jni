SHELL := bash

ROOT=$(shell pwd)

export JAVA_HOME := $(GRAALVM)
export PATH := $(ROOT):$(JAVA_HOME)/bin:$(PATH)
export LD_LIBRARY_PATH := $(ROOT)

NAME := HelloWorld
APP  := helloworld


test: build test-jar test-native

build: lib$(NAME).so $(APP)
	@echo

test-jar: lib$(NAME).so $(NAME).jar
	@echo '*** Testing $@'
	java -jar $(word 2,$^)
	@echo

test-native: lib$(NAME).so $(APP)
	@echo '*** Testing $@'
	$(word 2,$^)
	@echo

clean:
	$(RM) src/*.class src/*.h *.jar *.so $(APP)
	$(RM) -r reports


$(APP): $(NAME).jar
	$(GRAALVM)/bin/native-image \
	  -jar $< \
	  -o $@

# This way with, all these other arguments (surprisingly) seem to have no
# effect (in 2024).
# Everything iseems to work to work fine without them.

# $(APP): $(NAME).jar
# 	$(GRAALVM)/bin/native-image \
# 	  -jar $< \
# 	  -H:Name=$@ \
# 	  --verbose \
# 	  --no-fallback \
# 	  --no-server \
# 	  "-J-Xmx1g" \
# 	  --initialize-at-build-time \
# 	  -H:+ReportExceptionStackTraces \
# 	  -H:ConfigurationFileDirectories=config-dir \
# 	  -H:+PrintClassInitialization

%.jar: src/%.class src/manifest.txt
	cd src && jar cfm ../$@ manifest.txt $(<:src/%=%)

src/%.class: src/%.java
	javac $<

lib%.so: src/%.c src/%.h
	gcc -shared -Wall -Werror \
		-I$(JAVA_HOME)/include \
		-I$(JAVA_HOME)/include/linux \
		-o $@ \
		-fPIC \
		$<

src/%.h: src/%.java
	cd src && javac -h $(PWD)/src $(<:src/%=%)
