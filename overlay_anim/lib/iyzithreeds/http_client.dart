abstract class HttpClient {
  Future<dynamic> get(String url);

  Future<dynamic> getV2(String url, Map<String, String> header);

  Future<dynamic> post(String url, Map<String, String> header, String content);

  Future<dynamic> put(String url, Map<String, String> header, String content);

  Future<dynamic> delete(String url, Map<String, String> header, [String? content]);
}
