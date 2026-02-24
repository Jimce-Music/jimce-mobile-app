class UrlHelper {
  static String formatServerUrl(String input) {
    String url = input.trim();
    if (url.isEmpty) return "";

    final ipRegex = RegExp(r'^\d{1,3}(\.\d{1,3}){3}$');
    
    if (ipRegex.hasMatch(url)) {
      url = "http://$url:8080/";
    } else if (RegExp(r'^\d{1,3}(\.\d{1,3}){3}:\d+$').hasMatch(url)) {
      url = "http://$url/";
    } else if (!url.startsWith("http://") && !url.startsWith("https://")) {
      url = "http://$url";
    }

    url = url.replaceAll(RegExp(r'/+$'), ''); 
    return "$url/";
  }
}