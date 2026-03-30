import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:overlay_anim/iyzithreeds/http_client.dart';

class DefaultHttpClient implements HttpClient {
  final http.Client _client;

  DefaultHttpClient([http.Client? client]) : _client = client ?? http.Client();

  static DefaultHttpClient create([http.Client? client]) {
    return DefaultHttpClient(client);
  }

  @override
  Future<http.Response> get(String url) {
    return _client.get(Uri.parse(url));
  }

  @override
  Future<http.Response> getV2(String url, Map<String, String> header) {
    return _client.get(
      Uri.parse(url),
      headers: header,
    );
  }

  @override
  Future<http.Response> post(String url, Map<String, String> header, String content) {
    return _client.post(
      Uri.parse(url),
      headers: header,
      body: content,
    );
  }

  @override
  Future<http.Response> put(String url, Map<String, String> header, String content) {
    return _client.put(
      Uri.parse(url),
      headers: header,
      body: content,
    );
  }

  @override
  Future<http.Response> delete(String url, Map<String, String> header, [String? content]) {
    return _client.delete(
      Uri.parse(url),
      headers: header,
      body: content,
    );
  }
}
