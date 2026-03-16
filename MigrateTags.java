import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;

public class MigrateTags {
    public static void main(String[] args) {
        try (Stream<Path> paths = Files.walk(Paths.get("src/main/webapp"))) {
            paths.filter(Files::isRegularFile)
                 .filter(p -> p.toString().endsWith(".jsp"))
                 .forEach(p -> {
                     try {
                         String content = new String(Files.readAllBytes(p));
                         String replaced = content.replace("http://java.sun.com/jsp/jstl/core", "jakarta.tags.core");
                         if (!content.equals(replaced)) {
                             Files.write(p, replaced.getBytes());
                             System.out.println("Updated: " + p);
                         }
                     } catch (Exception e) {
                         e.printStackTrace();
                     }
                 });
            System.out.println("Done!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
