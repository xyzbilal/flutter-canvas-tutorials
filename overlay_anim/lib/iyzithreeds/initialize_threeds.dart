import 'package:overlay_anim/iyzithreeds/api_resource.dart';
import 'package:overlay_anim/iyzithreeds/payment_model.dart';

import 'options.dart';
import 'iyzipay_resource.dart';
import 'request.dart';
import 'threeds_initialize_mapper.dart';

class ThreedsInitialize extends IyzipayResource {
  String? htmlContent;

  // Statik 'create' metodu
  static Future<ThreedsInitialize> create(Request request, Options options) async {
    var httpClient = ApiResource.httpClient;
    var url = options.baseUrl + "/payment/3dsecure/initialize";
    var headers = IyzipayResource.getHttpHeaders(request, options);
    var rawResult = await httpClient.post(url,  headers,  request.toJsonString());

    // ThreedsInitializeMapper işlemleri
     var bla =  ThreedsInitializeMapper.create(rawResult);

        bla.jsonDecodeObject() ;
       final d = bla.mapThreedsInitialize(ThreedsInitialize());
        return d;
  }

  // Getter metodu
  String? getHtmlContent() {
    return htmlContent;
  }

  // Setter metodu
  void setHtmlContent(String htmlContent) {
    this.htmlContent = htmlContent;
  }
}