class HelloWorld {
    // Putting System.loadLibrary() here forces us to mark this class to
    // initialize at runtime when building with native-image:
    // https://github.com/oracle/graal/issues/1828
    //
    // static {
    //     System.loadLibrary("HelloWorld");
    // }

    private native void greet();

    // entry point
    public static void main(String[] args) {
        // Instead we System.loadLibrary() inside the execution path to load
        // the library file.
        System.loadLibrary("helloworld.1.2.3");
        new HelloWorld().greet();
    }
}

// System.setProperty(
//     "java.library.path",
//     String.format(
//         "%s:%s",
//         "some/path",
//         System.getProperty("java.library.path")
//     )
// );
// System.out.printf(
//     "java.library.path: %s\n",
//     System.getProperty("java.library.path")
// );
