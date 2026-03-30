import 'dart:convert';

import 'initialize_threeds.dart';
import 'iyzipay_resource_mapper.dart';

class ThreedsInitializeMapper extends IyzipayResourceMapper {
  String? rawResult;
  dynamic jsonObject;

  ThreedsInitializeMapper(this.rawResult) : super('') {
    jsonObject = jsonDecode(rawResult ?? '{}');
  }

  // Factory method 'create'
  static ThreedsInitializeMapper create(String? rawResult) {
    return ThreedsInitializeMapper(rawResult);
  }

  // 'mapThreedsInitializeFrom' methodu
  ThreedsInitialize mapThreedsInitializeFrom(ThreedsInitialize initialize, dynamic jsonObject) {
    mapResourceFrom(initialize, jsonObject);

    if (jsonObject['threeDSHtmlContent'] != null) {
      initialize.htmlContent = String.fromCharCodes(base64Decode(jsonObject['threeDSHtmlContent']));
    }
    return initialize;
  }

  // 'mapThreedsInitialize' methodu
  ThreedsInitialize mapThreedsInitialize(ThreedsInitialize initialize) {
    return mapThreedsInitializeFrom(initialize, jsonObject);
  }
}


