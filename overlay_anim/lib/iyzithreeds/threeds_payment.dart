import 'options.dart';
import 'request.dart';
/*
class ThreedsPayment extends PaymentResource {
  // Statik 'create' metodu
  static Future<ThreedsPayment> create(Request request, Options options) async {
    var httpClient = PaymentResource.httpClient();
    var url = "${options.getBaseUrl()}/payment/3dsecure/auth";
    var headers = PaymentResource.getHttpHeaders(request, options);
    var rawResult = await httpClient.post(url, headers: headers, body: request.toJsonString());

    // ThreedsPaymentMapper işlemleri
    return ThreedsPaymentMapper.create(rawResult)
        .jsonDecode()
        .mapThreedsPayment(ThreedsPayment());
  }

  // Statik 'retrieve' metodu
  static Future<ThreedsPayment> retrieve(Request request, Options options) async {
    var httpClient = PaymentResource.httpClient();
    var url = "${options.getBaseUrl()}/payment/detail";
    var headers = PaymentResource.getHttpHeaders(request, options);
    var rawResult = await httpClient.post(url, headers: headers, body: request.toJsonString());

    // ThreedsPaymentMapper işlemleri
    return ThreedsPaymentMapper.create(rawResult)
        .jsonDecode()
        .mapThreedsPayment(ThreedsPayment());
  }
}

*/
