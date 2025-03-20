package net.ingy;

import java.io.File;
import java.io.InputStream;
import java.io.IOException;

import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

class NativeLoader {
    public static void loadLibraryFromResource(String libraryName)
        throws IOException
    {
        ClassLoader classLoader =
            Thread.currentThread().getContextClassLoader();
        InputStream inputStream =
            classLoader.getResourceAsStream(libraryName);

        File tempDir = createTempDir();
        tempDir.deleteOnExit();
        File tempFile = new File(tempDir, libraryName);

        Files.copy(
            inputStream,
            tempFile.toPath(),
            StandardCopyOption.REPLACE_EXISTING);
        inputStream.close();

        try { System.load(tempFile.getAbsolutePath()); }
        finally { tempFile.delete(); }
    }

    private static File createTempDir() throws IOException {
        String tempBase = System.getProperty("java.io.tmpdir");
        File tempDir = new File(tempBase, "" + System.nanoTime());
        if (! tempDir.mkdir())
            throw new IOException(
                "Failed to create temp directory " +
                tempDir.getName());
        return tempDir;
    }
}
