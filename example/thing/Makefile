ROOT := ../..
include $(ROOT)/common/begin.mk


test: fortune
	./$<

fortune: Fortune.class
	native-image -Ob Fortune

%.class: %.java $(GRAALVM_HOME)
	javac $<

clean:
	$(RM) *.class fortune fortune-build-report.html

$(GRAALVM_HOME): $(GRAALVM_TAR)
	tar -C $(TEMP) -xf $<
	touch $@

$(GRAALVM_TAR):
	curl -sSL -o $@ $(GRAALVM_LINUX_X86_REPO)
	touch $@
