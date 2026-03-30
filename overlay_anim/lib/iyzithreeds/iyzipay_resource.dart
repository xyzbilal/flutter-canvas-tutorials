import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' hide Request;
import 'package:overlay_anim/iyzithreeds/hash_generator.dart';

import 'api_resource.dart';
import 'default_http_client.dart';
import 'http_client.dart';
import 'iyzi_authv2_generator.dart';
import 'options.dart';
import 'request.dart';

class IyzipayResource extends ApiResource {
  String? _status;
  String? _errorCode;
  String? _errorMessage;
  String? _errorGroup;
  String? _locale;
  String? _systemTime;
  String? _conversationId;

  // Static method for getting HTTP headers
  static Map<String,String> getHttpHeaders(Request request, Options options) {
   var header = <String,String>{
      'Accept': 'application/json',
      'Content-type': 'application/json'
    };

    final rnd = UniqueKey().toString(); // Generating a unique key
    header.putIfAbsent('Authorization', ()=>'${prepareAuthorizationString(request, options, rnd)}');
    header.putIfAbsent('x-iyzi-rnd',()=> '$rnd');
    header.putIfAbsent('x-iyzi-client-version',()=> 'iyzipay-dart-1.0.0');

    return header;
  }

  // Static method for getting HTTP headers v2
  static Map<String,String> getHttpHeadersV2(String uri, Request? request, Options options) {
    var header = <String,String>{
      'Accept': 'application/json',
      'Content-type': 'application/json'
    };

    final rnd = UniqueKey().toString(); // Generating a unique key
    header.putIfAbsent('Authorization', ()=>'${prepareAuthorizationStringV2(uri, request, options, rnd)}');
    header.putIfAbsent('x-iyzi-client-version',()=> 'iyzipay-dart-1.0.0');

    return header;
  }

  // Static method for preparing authorization string
  static String prepareAuthorizationString(Request request, Options options, String rnd) {
    final authContent = HashGenerator.generateHash(options.apiKey, options.secretKey, rnd, request);
    return 'IYZWS ${options.apiKey}:$authContent';
  }

  // Static method for preparing authorization string v2
  static String prepareAuthorizationStringV2(String uri, Request? request, Options options, String rnd) {
    final hash = IyziAuthV2Generator.generateAuthContent(uri, options.apiKey, options.secretKey, rnd, request);
    return 'IYZWSv2 $hash';
  }

  // Getters and setters
  String? get status => _status;

  set status(String? status) => _status = status;

  String? get errorCode => _errorCode;

  set errorCode(String? errorCode) => _errorCode = errorCode;

  String? get errorMessage => _errorMessage;

  set errorMessage(String? errorMessage) => _errorMessage = errorMessage;

  String? get errorGroup => _errorGroup;
  
  set errorGroup(String? errorGroup) => _errorGroup = errorGroup;

  String? get locale => _locale;
  set locale(String? locale) => _locale = locale;

  String? get systemTime => _systemTime;
  set systemTime(String? systemTime) => _systemTime = systemTime;

  String? get conversationId => _conversationId;
  set conversationId(String? conversationId) => _conversationId = conversationId;
}
