# graal-native-image-jni

### Aim

Try and build the smallest possible JNI example to test GraalVM's native-image JNI support.

### Result

Success.

```
$ make test
...lots of output...
Hello world; this is C talking!
```

### Insight

In order for native-image to successfuly load a c library to execute, it must run the `System.loadLibrary()` call at runtime, not at build time.

### Method 1: Put loadLibrary in the execution path

This is the version we have done. By putting loadLibrary inside the `main` method, the library is loaded at run time. With this setup we can compile with `--initialize-at-build-time` and everything will work.

### Method 2: Put loadLibrary in static class initializer and use --initialize-at-run-time

Sometimes you don't have control over where you call loadLibrary from. Often existing code places it in the class's static initializer block. In this case the library is loaded at build time, but then when the final artifact is run, the linked code cannot be found and the programme crashes with a `java.lang.UnsatisfiedLinkError` exception.

When you place the loadLibrary call within a static block of a class, you must specify to `native-image` that your class should be initialized at runtime.

## Requirements

 * Linux
 * Download and untar one of the following URLs into any directory and set in `GRAALVM=...` below)
   * [Oracle Free GraalVM](
     https://download.oracle.com/graalvm/22/latest/graalvm-jdk-22_linux-x64_bin.tar.gz)
   * [GraalVM Community Edition](https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-22.0.2/graalvm-community-jdk-22.0.2_linux-x64_bin.tar.gz)
 * Working GNU C compiler

The downloaded GraalVM directory contains all the assets you need to run here including `java`, `javac`, the JDK and the `native-image` compiler. In other words you don't need to install anything to try this.

## Overview

`HelloWorld.java` contains HelloWorld class, that calls the native code in `HelloWorld.c` to print output.

`HelloWorld.c` compiles into `libHelloWorld.so`

`HelloWorld.class` is built into a jar with a simple manifest.

## Testing with the `make` commands

* `make test GRAALVM=/path/to/graalvm-bundle-dir`

  Test running both Java jar file and native image

* `make test-jar GRAALVM=/path/to/graalvm-bundle-dir`

  Test running the Java jar file

* `make test-native GRAALVM=/path/to/graalvm-bundle-dir`

  Test running the native-image binary executable
