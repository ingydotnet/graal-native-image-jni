package net.ingy;

import net.ingy.NativeLoader;

import java.io.IOException;

class HelloWorld {
    private native void greet();

    public static void main(String[] args) throws IOException {
        (new HelloWorld()).greet();
    }

    public HelloWorld() throws IOException {
        String libraryName = "libhelloworld.1.2.3.so";
        NativeLoader.loadLibraryFromResource(libraryName);
    }
}
