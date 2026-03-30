import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:overlay_anim/ext.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_anim/iyzithreeds/hash_generator.dart';
import 'package:overlay_anim/iyzithreeds/payment_model.dart';
import 'package:overlay_anim/iyzithreeds/request.dart';

import 'iyzithreeds/options.dart';

class EasyPay extends StatefulWidget {
  const EasyPay({ Key? key});

  @override
  State<EasyPay> createState() => _EasyPayState();
}

class _EasyPayState extends State<EasyPay> {


  String decodedHtml = "";

  @override
  void initState() {
   create3Ds();
    super.initState();
  }


  void create3Ds(){

  var url = Uri.parse('https://sandbox-api.iyzipay.com/payment/3dsecure/initialize'); // Iyzipay endpoint URL

  // Request body
  var requestBody = {
    "locale": "tr",
    "conversationId": "123456789",
    "price": "1.0",
    "paidPrice": "1.2",
    "installment": 1,
    "paymentChannel": "WEB",
    "basketId": "B67832",
    "paymentGroup": "PRODUCT",
    "paymentCard": {
        "cardHolderName": "John Doe",
        "cardNumber": "5528790000000008",
        "expireYear": "2030",
        "expireMonth": "12",
        "cvc": "123"
    },
    "buyer": {
        "id": "BY789",
        "name": "John",
        "surname": "Doe",
        "identityNumber": "74300864791",
        "email": "email@email.com",
        "gsmNumber": "+905350000000",
        "registrationDate": "2013-04-21 15:12:09",
        "lastLoginDate": "2015-10-05 12:43:35",
        "registrationAddress": "Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1",
        "city": "Istanbul",
        "country": "Turkey",
        "zipCode": "34732",
        "ip": "85.34.78.112"
    },
    "shippingAddress": {
        "address": "Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1",
        "zipCode": "34742",
        "contactName": "Jane Doe",
        "city": "Istanbul",
        "country": "Turkey"
    },
    "billingAddress": {
        "address": "Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1",
        "zipCode": "34742",
        "contactName": "Jane Doe",
        "city": "Istanbul",
        "country": "Turkey"
    },
    "basketItems": [
        {
            "id": "BI101",
            "price": "0.3",
            "name": "Binocular",
            "category1": "Collectibles",
            "category2": "Accessories",
            "itemType": "PHYSICAL"
        },
        {
            "id": "BI102",
            "price": "0.5",
            "name": "Game code",
            "category1": "Game",
            "category2": "Online Game Items",
            "itemType": "VIRTUAL"
        },
        {
            "id": "BI103",
            "price": "0.2",
            "name": "Usb",
            "category1": "Electronics",
            "category2": "Usb / Cable",
            "itemType": "PHYSICAL"
        }
    ],
    "currency": "TRY",
    "callbackUrl": "https://www.merchant.com/callback"
};

final random = math.Random().nextInt(999999999);

final string = formatMap(requestBody);

final apiKey = "sandbox-qC0GTsCIyboeCMS5G4Pe5S23vviz8rte";

final secretKey = "sandbox-sY5GvOuXo16sJgIu2Q4veW23wgpCZy6I";


final pkiString = "[${string}]";

final hashString = '$apiKey$random$secretKey$pkiString';

    log( pkiString);


    List<int> bytes = utf8.encode(hashString);
    List<int> digest = sha1.convert(bytes).bytes;
    
    final d =  base64Encode(digest);

    log("IYZWS $apiKey:${d}");


 var header = <String,String>{
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization':'IYZWS $apiKey:${d}',
      'x-iyzi-rnd': random.toString(),

    };

    http.post(url, headers: header, body: jsonEncode(requestBody)).then((response) {
      log(response.body);

      if (response.statusCode == 200) {
        final threeDsInitAnswer = threeDsInitAnswerFromJson(response.body);

          decodedHtml = utf8.decode(base64Decode(threeDsInitAnswer.threeDsHtmlContent));

          log(decodedHtml);
           setState(() { });
      } else {
        log("Error: ${response.statusCode}");
      }

    }).catchError((error) {
      print(error);
    });
  }




String formatMap(Map<String, dynamic> data) {

  String formatSubMap(Map subMap) {
    return subMap.entries
        .where((entry) => entry.value != null)
        .map((entry) => '${entry.key}=${entry.value}')
        .join(',');
  }

  String formatList(List<dynamic> list) {
    return list.map((item) {
      if (item is Map) {
        return '[${formatSubMap(item)}]';
      }
      return item.toString();
    }).join(', ');
  }

  return data.entries.where((entry) => entry.value != null).map((entry) {
    if (entry.value is Map) {
      return '${entry.key}=[${formatSubMap(entry.value)}]';
    } else if (entry.value is List) {
      return '${entry.key}=[${formatList(entry.value)}]';
    } else {
      return '${entry.key}=${entry.value}';
    }
  }).join(',');
}






String prepareAuthorizationString( Options options, String rnd) {
  
 return 'IYZWS ${options.apiKey}:';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: decodedHtml.isEmpty ? Center(child: CircularProgressIndicator(),) :
 
      Html(
        data: """<!doctype html>
      <html lang="en">
      <head>
          <title>iyzico Mock 3D-Secure Processing Page</title>
      </head>
      <body>
      <form id="iyzico-3ds-form" action="https://sandbox-api.iyzipay.com/payment/mock/init3ds" method="post">
          <input type="hidden" name="orderId" value="mock12-8559997407827133iyziord">
          <input type="hidden" name="bin" value="552879">
          <input type="hidden" name="successUrl" value="https://sandbox-api.iyzipay.com/payment/iyzipos/callback3ds/success/3">
          <input type="hidden" name="failureUrl" value="https://sandbox-api.iyzipay.com/payment/iyzipos/callback3ds/failure/3">
          <input type="hidden" name="confirmationUrl" value="https://sandbox-api.iyzipay.com/payment/mock/confirm3ds">
          <input type="hidden" name="PaReq" value="d6d4f4fa-9c1d-4b94-9522-eff5a1391449">
      </form>
      <script type="text/javascript">
          document.getElementById("iyzico-3ds-form").submit();
      </script>
      </body>
      </html>""", // Çözülen HTML içeriği burada gösterilir
      ),
  
    
    );
  }
}






class Config {
  static  options() {
    final options = Options();
    options.apiKey = 'sandbox-qC0GTsCIyboeCMS5G4Pe5S23vviz8rte';
    options.secretKey = 'sandbox-sY5GvOuXo16sJgIu2Q4veW23wgpCZy6I';
    options.baseUrl = 'https://sandbox-api.iyzipay.com';
    
    return options;
  }
}



final s = "sandbox-qC0GTsCIyboeCMS5G4Pe5S23vviz8rte123456789sandbox-sY5GvOuXo16sJgIu2Q4veW23wgpCZy6I[locale=tr,conversationId=123456789,price=1.0,paidPrice=1.2,installment=1,paymentChannel=WEB,basketId=B67832,paymentGroup=PRODUCT,paymentCard=[cardHolderName=John Doe,cardNumber=5528790000000008,expireYear=2030,expireMonth=12,cvc=123],buyer=[id=BY789,name=John,surname=Doe,identityNumber=74300864791,email=email@email.com,gsmNumber=+905350000000,registrationDate=2013-04-21 15:12:09,lastLoginDate=2015-10-05 12:43:35,registrationAddress=Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1,city=Istanbul,country=Turkey,zipCode=34732,ip=85.34.78.112],shippingAddress=[address=Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1,zipCode=34742,contactName=Jane Doe,city=Istanbul,country=Turkey],billingAddress=[address=Nidakule Göztepe, Merdivenköy Mah. Bora Sok. No:1,zipCode=34742,contactName=Jane Doe,city=Istanbul,country=Turkey],basketItems=[[id=BI101,price=0.3,name=Binocular,category1=Collectibles,category2=Accessories,itemType=PHYSICAL], [id=BI102,price=0.5,name=Game code,category1=Game,category2=Online Game Items,itemType=VIRTUAL], [id=BI103,price=0.2,name=Usb,category1=Electronics,category2=Usb / Cable,itemType=PHYSICAL]],currency=TRY,callbackUrl=https://www.merchant.com/callback]";





// To parse this JSON data, do
//
//     final threeDsInitAnswer = threeDsInitAnswerFromJson(jsonString);


ThreeDsInitAnswer threeDsInitAnswerFromJson(String str) => ThreeDsInitAnswer.fromJson(json.decode(str));

String threeDsInitAnswerToJson(ThreeDsInitAnswer data) => json.encode(data.toJson());

class ThreeDsInitAnswer {
    String status;
    String locale;
    int systemTime;
    String conversationId;
    String threeDsHtmlContent;
    String paymentId;
    String signature;

    ThreeDsInitAnswer({
        required this.status,
        required this.locale,
        required this.systemTime,
        required this.conversationId,
        required this.threeDsHtmlContent,
        required this.paymentId,
        required this.signature,
    });

    factory ThreeDsInitAnswer.fromJson(Map<String, dynamic> json) => ThreeDsInitAnswer(
        status: json["status"],
        locale: json["locale"],
        systemTime: json["systemTime"],
        conversationId: json["conversationId"],
        threeDsHtmlContent: json["threeDSHtmlContent"],
        paymentId: json["paymentId"],
        signature: json["signature"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "locale": locale,
        "systemTime": systemTime,
        "conversationId": conversationId,
        "threeDSHtmlContent": threeDsHtmlContent,
        "paymentId": paymentId,
        "signature": signature,
    };
}
