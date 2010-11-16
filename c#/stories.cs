using System;
using System.Collections.Generic;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web.Script.Serialization;

class StoryFinder {
  private const string BASE_URL = "http://hyperlocal-api.outside.in/v1.1";

  private string key = null;
  private string secret = null;
  private MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
  private WebClient web = new WebClient();
  private JavaScriptSerializer json = new JavaScriptSerializer();

  public StoryFinder(string key, string secret) {
    this.key = key;
    this.secret = secret;
  }

  public List<Dictionary<string, object>> FindStories(string name) {
    List<Dictionary<string, object>> locations =
      this.request(String.Format("/locations/named/{0}", Uri.EscapeUriString(name)), "locations");
    if (locations.Count == 0) {
      throw new Exception(String.Format("No location named {0}", name));
    }
    return this.request(String.Format("/locations/{0}/stories", Uri.EscapeUriString((string) locations[0]["uuid"])),
      "stories");
  }

  private List<Dictionary<string, object>> request(string path, string field) {
    string url = this.sign(String.Format("{0}{1}", BASE_URL, path));
    Console.WriteLine("Requesting {0}", url);
    string data = this.web.DownloadString(url);
    Dictionary<string, object> result = this.json.Deserialize<Dictionary<string, object>>(data);
    return (List<Dictionary<string, object>>) result[field];
  }

  private string sign(string url) {
    int time = (int) (DateTime.UtcNow - new DateTime(1970, 1, 1)).TotalSeconds;
    string sig = this.md5hex(String.Format("{0}{1}{2}", this.key, this.secret, time.ToString()));
    return String.Format("{0}?dev_key={1}&sig={2}", url, this.key, sig);
  }

  private string md5hex(string str) {
    byte[] data = Encoding.Default.GetBytes(str);
    byte[] hash = this.md5.ComputeHash(data);
    string hex = "";
    foreach (byte b in hash) {
      hex += String.Format("{0:x2}", b);
    }
    return hex;
  }

  static public void Main(string[] args) {
    if (args.Length != 3) {
      Console.WriteLine("Usage: stories.exe <developer key> <shared secret> <location>");
      Environment.Exit(1);
    }

    try {
      List<Dictionary<string, object>> stories = new StoryFinder(args[0], args[1]).FindStories(args[2]);
      if (stories.Count == 0) {
        Console.WriteLine("Found 0 stories.");
      } else {
        Console.WriteLine("Found {0} stories:", stories.Count);
        foreach (Dictionary<string, object> story in stories) {
          Console.WriteLine("  {0}", story["title"]);
        }
      }
    } catch (Exception e) {
      Console.WriteLine(e.ToString());
      Environment.Exit(2);
    }
  }
}
