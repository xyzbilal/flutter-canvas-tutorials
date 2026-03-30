import 'package:overlay_anim/iyzithreeds/http_client.dart';

import 'default_http_client.dart';

class ApiResource {
  
  static HttpClient? _httpClient;
  String? _rawResult;

  // Static getter for httpClient
  static HttpClient get httpClient {
    _httpClient ??= DefaultHttpClient.create();
    return _httpClient!;
  }

  // Static setter for httpClient
  static set httpClient(HttpClient client) {
    _httpClient = client;
  }

  // Getter for rawResult
  String? get rawResult => _rawResult;

  // Setter for rawResult
  set rawResult(String? rawResult) {
    _rawResult = rawResult;
  }
}
