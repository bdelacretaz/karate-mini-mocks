package server;

import com.intuit.karate.FileUtils;
import com.intuit.karate.netty.FeatureServer;
import java.io.File;
import org.junit.AfterClass;
import org.junit.BeforeClass;

/** Base class for tests, takes care of starting and stopping
 *  the mock server.
 */
public class TestBase {
    
    private static FeatureServer server;
    
    @BeforeClass
    public static void setup() {
        File file = FileUtils.getFileRelativeTo(TestBase.class, "server.feature");
        server = FeatureServer.start(file, 0, false, null);
        System.setProperty("karate.env", "mock");
        System.setProperty("mock.server.url", "http://localhost:" + server.getPort());
    }
    
    @AfterClass
    public static void cleanup() {
        if(server != null) {
            server.stop();
            server = null;
        }
    }
}