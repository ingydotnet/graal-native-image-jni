name := $(shell echo $(NAME) | tr A-Z a-z)
NATIVE := $(name)
JAR  := $(NAME).jar
VER  := 1.2.3
LIB  := lib/lib$(name).$(VER).so


default:

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
	$(RM) src/*.class src/*.h $(JAR) $(LIB) $(NATIVE)
	$(RM) helloworld-build-report.html
	$(RM) -r reports bin lib target

sysclean: clean
	$(RM) $(GRAALVM_TAR)
	$(RM) -r $(GRAALVM_HOME)

ifeq (1,$(USE_NATIVE_OPTS))
NATIVE_OPTS := \
  --verbose \
  --native-image-info \
  --no-fallback \
  --initialize-at-build-time \
  --enable-preview \
  --enable-url-protocols=https \
  -march=compatibility \
  -H:ReflectionConfigurationFiles=reflection.json \
  -H:+ReportExceptionStackTraces \
  -H:+PrintClassInitialization \
  -H:Log=registerResource: \
  "-J-Xmx3g"
endif

ifeq (2,$(USE_NATIVE_OPTS))
NATIVE_OPTS := \
  -H:IncludeResources=".*libhelloworld\.1\.2\.3\.so" \
  "-J-Xmx3g"
endif

ifeq (3,$(USE_NATIVE_OPTS))
NATIVE_OPTS := \
  -H:IncludeResources=".*libhelloworld\.1\.2\.3\.so" \
  "-J-Xmx3g"
endif

# Using none of the options above (or using all of them) both seem to work as
# of March 2025.

$(NATIVE): $(JAR)
	native-image $(NATIVE_OPTS) -Ob -jar $< -o $@

$(JAR): src/$(NAME).class src/manifest.txt $(LIB)
	cd src && jar cfm ../$@ manifest.txt $(NAME).class

src/%.class: src/%.java $(GRAALVM_HOME)
	javac $<

$(LIB): src/$(NAME).c src/$(NAME).h
	mkdir -p lib
	gcc -shared -Wall -Werror \
		-I$(JAVA_HOME)/include \
		-I$(JAVA_HOME)/include/linux \
		-o $@ \
		-fPIC \
		$<

src/%.h: src/%.java
	cd src && javac -h $(BASE)/src $(<:src/%=%)

$(GRAALVM_HOME): $(GRAALVM_TAR)
	tar -C $(TEMP) -xf $<
	touch $@

$(GRAALVM_TAR):
	curl -sSL -o $@ $(GRAALVM_LINUX_X86_REPO)
	touch $@
