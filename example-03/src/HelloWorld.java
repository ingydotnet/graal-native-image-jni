import java.nio.file.Path;
import java.nio.file.Paths;

class HelloWorld {
    private native void greet();
    public static void main(String[] args) {
        Path currentRelativePath = Paths.get("");
        String cwd = currentRelativePath.toAbsolutePath().toString();
        System.load(cwd + "/lib/libhelloworld.1.2.3.so");
        new HelloWorld().greet();
    }
}
