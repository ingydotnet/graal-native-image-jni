include ../common/begin.mk

NAME := HelloWorld

NATIVE_OPTS := \
  -H:ResourceConfigurationFiles=resources.json \

include $(COMMON)/end.mk

run-jar: $(JAR)
	java -jar $<

$(JAR)::
	jar uf $@ -C lib libhelloworld.1.2.3.so


#   --emit=build-report \
#   -H:ResourceConfigurationFiles=resources2.json \
#   -H:Log=registerResource: \
#   -H:IncludeResources=.*[hH]ello.* \
#   -H:IncludeResources=lib/libhelloworld.1.2.3.so \
#   -H:ResourceConfigurationFiles=resources.json \
