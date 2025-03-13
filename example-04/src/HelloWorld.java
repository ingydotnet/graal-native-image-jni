import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

class HelloWorld {
    private native void greet();
    public static void main(String[] args) {
        Path currentRelativePath = Paths.get("");
        String cwd = currentRelativePath.toAbsolutePath().toString();
        String path = cwd + "/lib/libhelloworld.1.2.3.so";
        if (Files.notExists(Paths.get(path))) {
            //System.out.printf("ppppppppppppppppppppppppp");
            path = "/lib/libhelloworld.1.2.3.so";
        }
        System.load(path);
        new HelloWorld().greet();
    }
}
