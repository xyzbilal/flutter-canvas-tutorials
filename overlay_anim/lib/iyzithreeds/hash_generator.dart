import 'dart:convert';
import 'package:crypto/crypto.dart';

import '../iyzithreeds/request.dart';

class HashGenerator {
  static String generateHash(String apiKey, String secretKey, String randomString, Request request) {
    String hashStr = '$apiKey$randomString$secretKey${request.toPKIRequestString()}';
    List<int> bytes = utf8.encode(hashStr);
    List<int> digest = sha1.convert(bytes).bytes;
    return base64Encode(digest);
  }
}
