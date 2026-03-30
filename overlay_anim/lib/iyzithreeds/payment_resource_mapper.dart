import 'dart:convert';

// Assuming these classes are defined elsewhere

import 'iyzipay_resource_mapper.dart';
import 'payment_item_mapper.dart';
import 'payment_resource.dart';

class PaymentResourceMapper extends IyzipayResourceMapper {
  PaymentResourceMapper(String? rawResult) : super(rawResult);

  factory PaymentResourceMapper.create(String? rawResult) {
    return PaymentResourceMapper(rawResult);
  }

  PaymentResource mapPaymentResourceFrom(PaymentResource paymentResource, Map<String, dynamic> jsonObject) {
   
    super.mapResourceFrom(paymentResource, jsonObject);

    if (jsonObject.containsKey('price')) {
      paymentResource.setPrice(jsonObject['price']);
    }
    if (jsonObject.containsKey('paidPrice')) {
      paymentResource.setPaidPrice(jsonObject['paidPrice']);
    }
    if (jsonObject.containsKey('installment')) {
      paymentResource.setInstallment(jsonObject['installment']);
    }
    if (jsonObject.containsKey('paymentId')) {
      paymentResource.setPaymentId(jsonObject['paymentId']);
    }
    if (jsonObject.containsKey('paymentStatus')) {
      paymentResource.setPaymentStatus(jsonObject['paymentStatus']);
    }
    if (jsonObject.containsKey('fraudStatus')) {
      paymentResource.setFraudStatus(jsonObject['fraudStatus']);
    }
    if (jsonObject.containsKey('merchantCommissionRate')) {
      paymentResource.setMerchantCommissionRate(jsonObject['merchantCommissionRate']);
    }
    if (jsonObject.containsKey('merchantCommissionRateAmount')) {
      paymentResource.setMerchantCommissionRateAmount(jsonObject['merchantCommissionRateAmount']);
    }
    if (jsonObject.containsKey('iyziCommissionRateAmount')) {
      paymentResource.setIyziCommissionRateAmount(jsonObject['iyziCommissionRateAmount']);
    }
    if (jsonObject.containsKey('iyziCommissionFee')) {
      paymentResource.setIyziCommissionFee(jsonObject['iyziCommissionFee']);
    }
    if (jsonObject.containsKey('cardType')) {
      paymentResource.setCardType(jsonObject['cardType']);
    }
    if (jsonObject.containsKey('cardAssociation')) {
      paymentResource.setCardAssociation(jsonObject['cardAssociation']);
    }
    if (jsonObject.containsKey('cardFamily')) {
      paymentResource.setCardFamily(jsonObject['cardFamily']);
    }
    if (jsonObject.containsKey('cardUserKey')) {
      paymentResource.setCardUserKey(jsonObject['cardUserKey']);
    }
    if (jsonObject.containsKey('cardToken')) {
      paymentResource.setCardToken(jsonObject['cardToken']);
    }
    if (jsonObject.containsKey('binNumber')) {
      paymentResource.setBinNumber(jsonObject['binNumber']);
    }
    if (jsonObject.containsKey('basketId')) {
      paymentResource.setBasketId(jsonObject['basketId']);
    }
    if (jsonObject.containsKey('currency')) {
      paymentResource.setCurrency(jsonObject['currency']);
    }
    if (jsonObject.containsKey('itemTransactions')) {
      paymentResource.setPaymentItems(
        PaymentItemMapper.create().mapPaymentItems(jsonObject['itemTransactions'])
      );
    }
    if (jsonObject.containsKey('connectorName')) {
      paymentResource.setConnectorName(jsonObject['connectorName']);
    }
    if (jsonObject.containsKey('authCode')) {
      paymentResource.setAuthCode(jsonObject['authCode']);
    }
    if (jsonObject.containsKey('phase')) {
      paymentResource.setPhase(jsonObject['phase']);
    }
    if (jsonObject.containsKey('lastFourDigits')) {
      paymentResource.setLastFourDigits(jsonObject['lastFourDigits']);
    }
    if (jsonObject.containsKey('posOrderId')) {
      paymentResource.setPosOrderId(jsonObject['posOrderId']);
    }
    
    return paymentResource;
  }

  PaymentResource mapPaymentResource(PaymentResource paymentResource) {
    return mapPaymentResourceFrom(paymentResource, jsonObject);
  }
}
