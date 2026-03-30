import 'dart:convert';

// Assuming these classes are defined elsewhere
import 'iyzipay_resource.dart'; 
import 'payment_item.dart';

class PaymentResource extends IyzipayResource {
  double? price;
  double? paidPrice;
  int? installment;
  String? currency;
  String? paymentId;
  String? paymentStatus;
  String? fraudStatus;
  double? merchantCommissionRate;
  double? merchantCommissionRateAmount;
  double? iyziCommissionRateAmount;
  double? iyziCommissionFee;
  String? cardType;
  String? cardAssociation;
  String? cardFamily;
  String? cardToken;
  String? cardUserKey;
  String? binNumber;
  String? basketId;
  List<PaymentItem>? paymentItems;
  String? connectorName;
  String? authCode;
  String? phase;
  String? lastFourDigits;
  String? posOrderId;

  PaymentResource();

  // Getters and Setters
  double? getPrice() => price;
  setPrice(double? value) => price = value;

  double? getPaidPrice() => paidPrice;
  setPaidPrice(double? value) => paidPrice = value;

  int? getInstallment() => installment;
  setInstallment(int? value) => installment = value;

  String? getCurrency() => currency;
  setCurrency(String? value) => currency = value;

  String? getPaymentId() => paymentId;
  setPaymentId(String? value) => paymentId = value;

  String? getPaymentStatus() => paymentStatus;
  setPaymentStatus(String? value) => paymentStatus = value;

  String? getFraudStatus() => fraudStatus;
  setFraudStatus(String? value) => fraudStatus = value;

  double? getMerchantCommissionRate() => merchantCommissionRate;
  setMerchantCommissionRate(double? value) => merchantCommissionRate = value;

  double? getMerchantCommissionRateAmount() => merchantCommissionRateAmount;
  setMerchantCommissionRateAmount(double? value) => merchantCommissionRateAmount = value;

  double? getIyziCommissionRateAmount() => iyziCommissionRateAmount;
  setIyziCommissionRateAmount(double? value) => iyziCommissionRateAmount = value;

  double? getIyziCommissionFee() => iyziCommissionFee;
  setIyziCommissionFee(double? value) => iyziCommissionFee = value;

  String? getCardType() => cardType;
  setCardType(String? value) => cardType = value;

  String? getCardAssociation() => cardAssociation;
  setCardAssociation(String? value) => cardAssociation = value;

  String? getCardFamily() => cardFamily;
  setCardFamily(String? value) => cardFamily = value;

  String? getCardToken() => cardToken;
  setCardToken(String? value) => cardToken = value;

  String? getCardUserKey() => cardUserKey;
  setCardUserKey(String? value) => cardUserKey = value;

  String? getBinNumber() => binNumber;
  setBinNumber(String? value) => binNumber = value;

  String? getBasketId() => basketId;
  setBasketId(String? value) => basketId = value;

  List<PaymentItem>? getPaymentItems() => paymentItems;
  setPaymentItems(List<PaymentItem>? value) => paymentItems = value;

  String? getConnectorName() => connectorName;
  setConnectorName(String? value) => connectorName = value;

  String? getAuthCode() => authCode;
  setAuthCode(String? value) => authCode = value;

  String? getPhase() => phase;
  setPhase(String? value) => phase = value;

  String? getLastFourDigits() => lastFourDigits;
  setLastFourDigits(String? value) => lastFourDigits = value;

  String? getPosOrderId() => posOrderId;
  setPosOrderId(String? value) => posOrderId = value;

  // JSON serialization
  factory PaymentResource.fromJson(Map<String, dynamic> json) {
    return PaymentResource()
      ..price = json['price']?.toDouble()
      ..paidPrice = json['paidPrice']?.toDouble()
      ..installment = json['installment']
      ..currency = json['currency']
      ..paymentId = json['paymentId']
      ..paymentStatus = json['paymentStatus']
      ..fraudStatus = json['fraudStatus']
      ..merchantCommissionRate = json['merchantCommissionRate']?.toDouble()
      ..merchantCommissionRateAmount = json['merchantCommissionRateAmount']?.toDouble()
      ..iyziCommissionRateAmount = json['iyziCommissionRateAmount']?.toDouble()
      ..iyziCommissionFee = json['iyziCommissionFee']?.toDouble()
      ..cardType = json['cardType']
      ..cardAssociation = json['cardAssociation']
      ..cardFamily = json['cardFamily']
      ..cardToken = json['cardToken']
      ..cardUserKey = json['cardUserKey']
      ..binNumber = json['binNumber']
      ..basketId = json['basketId']
      ..paymentItems = (json['itemTransactions'] as List<dynamic>?)
          ?.map((item) => PaymentItem.fromJson(item as Map<String, dynamic>))
          .toList()
      ..connectorName = json['connectorName']
      ..authCode = json['authCode']
      ..phase = json['phase']
      ..lastFourDigits = json['lastFourDigits']
      ..posOrderId = json['posOrderId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'paidPrice': paidPrice,
      'installment': installment,
      'currency': currency,
      'paymentId': paymentId,
      'paymentStatus': paymentStatus,
      'fraudStatus': fraudStatus,
      'merchantCommissionRate': merchantCommissionRate,
      'merchantCommissionRateAmount': merchantCommissionRateAmount,
      'iyziCommissionRateAmount': iyziCommissionRateAmount,
      'iyziCommissionFee': iyziCommissionFee,
      'cardType': cardType,
      'cardAssociation': cardAssociation,
      'cardFamily': cardFamily,
      'cardToken': cardToken,
      'cardUserKey': cardUserKey,
      'binNumber': binNumber,
      'basketId': basketId,
      'itemTransactions': paymentItems?.map((item) => item.toJson()).toList(),
      'connectorName': connectorName,
      'authCode': authCode,
      'phase': phase,
      'lastFourDigits': lastFourDigits,
      'posOrderId': posOrderId,
    };
  }
}
