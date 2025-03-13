class HelloWorld {
    private native void greet();
    public static void main(String[] args) {
        System.loadLibrary("helloworld.1.2.3");
        new HelloWorld().greet();
    }
}
