package in.outside;

import java.io.IOException;
import java.net.URI;
import java.util.List;
import java.util.Map;
import org.apache.commons.codec.digest.DigestUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

public class StoryFinder {
  private static final String SCHEME = "http";
  private static final String AUTHORITY = "hyperlocal-api.outside.in";
  private static final String BASE_PATH = "/v1.1";
  private static ObjectMapper MAPPER = new ObjectMapper();
  private static TypeReference TYPEREF = new TypeReference<Map<String, Object>>() {};

  private String key = null;
  private String secret = null;

  public StoryFinder(String key, String secret) {
    this.key = key;
    this.secret = secret;
  }

  public List<Map<String, Object>> findStories(String name) throws Exception {
    List<Map<String, Object>> locations = request(String.format("/locations/named/%s", name), "locations");
    if (locations.isEmpty())
      throw new Exception(String.format("No location named %s", name));
    return request(String.format("/locations/%s/stories", locations.get(0).get("uuid")), "stories");
  }

  private List<Map<String, Object>> request(String relativePath, String field) throws Exception {
    String path = String.format("%s%s", BASE_PATH, relativePath);
    long time = System.currentTimeMillis() / 1000L;
    String sig = DigestUtils.md5Hex(String.format("%s%s%s", this.key, this.secret, new Long(time)));
    String query = String.format("dev_key=%s&sig=%s", this.key, sig);
    URI uri = new URI(SCHEME, AUTHORITY, path, query, null);
    System.out.println(String.format("Requesting %s", uri));
    Map<String, Object> result = MAPPER.readValue(uri.toURL(), TYPEREF);
    return (List<Map<String, Object>>) result.get(field);
  }

  public static void main(String[] args) {
    if (args.length != 3) {
      System.out.println("Usage: java -jar stories.jar <developer key> <shared secret> <location>");
      System.exit(1);
    }

    try {
      List<Map<String, Object>> stories = new StoryFinder(args[0], args[1]).findStories(args[2]);
      if (stories.isEmpty()) {
        System.out.println("Found 0 stories");
      } else {
        System.out.println(String.format("Found %d stories", stories.size()));
        for (Map<String, Object> story: stories) {
          System.out.println(String.format("  %s", story.get("title")));
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
      System.exit(2);
    }
  }
}
