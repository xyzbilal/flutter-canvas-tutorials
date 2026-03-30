import 'dart:convert';
import 'package:crypto/crypto.dart';

import '../iyzithreeds/request.dart'; // Dart's crypto library

class IyziAuthV2Generator {
  
  static String generateAuthContent(String uri, String apiKey, String secretKey, String randomString, [Request? request]) {
    String hashStr = "apiKey:$apiKey&randomKey:$randomString&signature:${getHmacSHA256Signature(uri, secretKey, randomString, request)}";
    return base64Encode(utf8.encode(hashStr));
  }

  static String getHmacSHA256Signature(String uri, String secretKey, String randomString, [Request? request]) {
    String dataToEncrypt = '$randomString${getPayload(uri, request)}';
    var key = utf8.encode(secretKey);
    var bytes = utf8.encode(dataToEncrypt);

    var hmac = Hmac(sha256, key);
    var digest = hmac.convert(bytes);
      // TODO
    return String.fromCharCodes(digest.bytes);
  }

  static String getPayload(String uri, [Request? request]) {
    int startNumber = uri.indexOf('/v2');
    int endNumber = uri.indexOf('?');

    if (uri.contains("subscription") || uri.contains("ucs")) {
      endNumber = uri.length;
      if (uri.contains('?')) {
        endNumber = uri.indexOf('?');
      }
    }

    endNumber -= startNumber;
    String uriPath = uri.substring(startNumber, endNumber);

    if (request != null && request.toJsonString() != '[]') {
      uriPath += request.toJsonString();
    }

    return uriPath;
  }
}

// Make sure you have this in your pubspec.yaml
// dependencies:
//   crypto: ^3.0.1
//   convert: ^3.0.0
