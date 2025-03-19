import java.io.File;
import java.io.InputStream;
import java.io.IOException;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;

class HelloWorld {
    private static File tempDir;
    private native void greet();

    public static void main(String[] args) throws IOException {
        (new HelloWorld()).greet();
    }

    public HelloWorld() throws IOException {
        String libraryName = "libhelloworld.1.2.3.so";
        loadLibraryFromResource(libraryName);
    }

    public static void loadLibraryFromResource(String libraryName)
        throws IOException
    {
        ClassLoader classLoader =
            Thread.currentThread().getContextClassLoader();

        tempDir = createTempDirectory("libhelloworld");

        tempDir.deleteOnExit();

        File tempFile = new File(tempDir, libraryName);

        Path tempFilePath = tempFile.toPath();

        InputStream inputStream =
            classLoader.getResourceAsStream(libraryName);

        Files.copy(
            inputStream,
            tempFilePath,
            StandardCopyOption.REPLACE_EXISTING
        );

        inputStream.close();

        try {
            System.load(tempFile.getAbsolutePath());
        }
        finally {
            tempFile.delete();
        }
    }

    private static File createTempDirectory(String prefix)
            throws IOException
    {
        String tempDir = System.getProperty("java.io.tmpdir");
        File generatedDir =
            new File(tempDir, prefix + "-" + System.nanoTime());

        if (! generatedDir.mkdir())
            throw new IOException(
                "Failed to create temp directory " +
                generatedDir.getName()
            );

        return generatedDir;
    }
}
