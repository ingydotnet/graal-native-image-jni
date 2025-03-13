example-02
==========

* Use options:
  * --verbose
  * --native-image-info
  * --no-fallback
  * --initialize-at-build-time
  * --enable-preview
  * --enable-url-protocols=https
  * -march=compatibility
  * -H:ReflectionConfigurationFiles=reflection.json
  * -H:+ReportExceptionStackTraces
  * -H:+PrintClassInitialization
  * -H:Log=registerResource:
  * "-J-Xmx3g"
* Calls System.loadLibrary("helloworld.1.2.3")
* Needs `LD_LIBRARY_PATH` to be set
