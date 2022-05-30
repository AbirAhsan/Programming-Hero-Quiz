class AppConfig {
  static const String appName = "Quiz";
  static const bool https = true;

  //configure this
  static const domainPath = "herosapp.nyc3.digitaloceanspaces.com";

  static const String apiEndPoint = "/api";

  //do not configure these below
  static const String protocol = https ? "https://" : "http://";
  static const String rawBaseUrl = "$protocol$domainPath";

  static const String developerCompanyUrl = "https://abirahsan.com";
}
