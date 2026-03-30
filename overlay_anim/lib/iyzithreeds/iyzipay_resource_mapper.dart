import 'dart:convert';

import 'iyzipay_resource.dart';

// IyzipayResourceMapper sınıfı
class IyzipayResourceMapper {
  String? rawResult;
  dynamic jsonObject;

  // Yapıcı metot
  IyzipayResourceMapper(this.rawResult) {
    jsonObject = jsonDecode(rawResult ?? '{}');
  }

  // 'create' metodu
  static IyzipayResourceMapper create(String? rawResult) {
    return IyzipayResourceMapper(rawResult);
  }

  // 'jsonDecode' metodu
  IyzipayResourceMapper jsonDecodeObject() {
    jsonObject = json.decode(rawResult ?? '{}');
    return this;
  }

  // 'mapResourceFrom' metodu
  IyzipayResource mapResourceFrom(IyzipayResource resource, dynamic jsonObject) {
    if (jsonObject['status'] != null) {
      resource. status = jsonObject['status'];
    }
    if (jsonObject['conversationId'] != null) {
      resource.conversationId = jsonObject['conversationId'];
    }
    if (jsonObject['errorCode'] != null) {
      resource.errorCode =jsonObject['errorCode'];
    }
    if (jsonObject['errorMessage'] != null) {
      resource.errorMessage = jsonObject['errorMessage'];
    }
    if (jsonObject['errorGroup'] != null) {
      resource.errorGroup = jsonObject['errorGroup'];
    }
    if (jsonObject['locale'] != null) {
      resource.locale = jsonObject['locale'];
    }
    if (jsonObject['systemTime'] != null) {
      resource.systemTime = jsonObject['systemTime'];
    }
    if (rawResult != null) {
      resource.rawResult = rawResult!;
    }
    return resource;
  }

  // 'mapResource' metodu
  IyzipayResource mapResource(IyzipayResource resource) {
    return mapResourceFrom(resource, jsonObject);
  }
}

