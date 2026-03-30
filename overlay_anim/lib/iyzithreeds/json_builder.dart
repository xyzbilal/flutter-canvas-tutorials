import 'base_model.dart';

import 'dart:convert' as j;


import 'json_convertable.dart';
import 'request_formatter.dart';

class JsonBuilder {

  Map<String, dynamic> json;

  JsonBuilder(this.json);

  factory JsonBuilder.create() {
    return JsonBuilder({});
  }

  factory JsonBuilder.fromJsonObject(Map<String, dynamic> json) {
    return JsonBuilder(json);
  }

  JsonBuilder add(String key, dynamic value) {
    if (value != null) {
      if (value is JsonConvertible) {
        json[key] = value.getJsonObject();
      } else {
        json[key] = value;
      }
    }
    return this;
  }

  JsonBuilder addPrice(String key, dynamic value) {
    if (value != null) {
      json[key] = RequestFormatter.formatPrice(value);
    }
    return this;
  }

  JsonBuilder addArray(String key, List<dynamic>? array) {
    if (array != null) {
      json[key] = array.asMap().map((index, value) {
        if (value is JsonConvertible) {
          return MapEntry(index.toString(), value.getJsonObject());
        } else {
          return MapEntry(index.toString(), value);
        }
      });
    }
    return this;
  }

  Map<String, dynamic> getObject() {
    return json;
  }

  static String jsonEncode(Map<String, dynamic> jsonObject) {
    return j.json.encode(jsonObject);
  }

  static Map<String, dynamic> jsonDecode(String rawResult) {
    return j.json.decode(rawResult);
  }
}
