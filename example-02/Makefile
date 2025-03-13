include ../common/begin.mk

NAME := HelloWorld

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

#  -H:IncludeResources=".*libhelloworld\.1\.2\.3\.so" \

include $(COMMON)/end.mk
