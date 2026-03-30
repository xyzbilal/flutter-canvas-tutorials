import 'dart:convert';

import 'json_convertable.dart';
import 'request_string_convertable.dart';


abstract class BaseModel implements JsonConvertible, RequestStringConvertible {
  String toJsonString() {
    return jsonEncode(getJsonObject());
  }
}
