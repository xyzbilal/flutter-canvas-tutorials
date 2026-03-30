class Options {
  late String _apiKey;
  late String _secretKey;
  late String _baseUrl;

  Options();

  String get apiKey => _apiKey;
  set apiKey(String value) => _apiKey = value;

  String get secretKey => _secretKey;
  set secretKey(String value) => _secretKey = value;

  String get baseUrl => _baseUrl;
  set baseUrl(String value) => _baseUrl = value;
}
