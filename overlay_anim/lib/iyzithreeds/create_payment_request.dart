
import 'package:overlay_anim/iyzithreeds/request_string_builder.dart';

import 'payment_model.dart';
import 'request.dart'; // Adjust import as needed

class CreatePaymentRequest extends Request {
  double? price;
  double? paidPrice;
  int? installment;
  String? paymentChannel;
  String? basketId;
  String? paymentGroup;
  double? reward;
  PaymentCard? paymentCard;
  Buyer? buyer;
  Address? shippingAddress;
  Address? billingAddress;
  List<BasketItem>? basketItems;
  String? paymentSource;
  String? currency;
  String? posOrderId;
  String? connectorName;
  bool? plusInstallmentUsage;
  String? callbackUrl;

  CreatePaymentRequest() {
    this.installment = 1;
  }

  // Getters and Setters

  double? getPrice() => price;
  setPrice(double? price) => this.price = price;

  double? getPaidPrice() => paidPrice;
  setPaidPrice(double? paidPrice) => this.paidPrice = paidPrice;

  int? getInstallment() => installment;
  setInstallment(int? installment) => this.installment = installment;

  String? getPaymentChannel() => paymentChannel;
  setPaymentChannel(String? paymentChannel) => this.paymentChannel = paymentChannel;

  String? getBasketId() => basketId;
  setBasketId(String? basketId) => this.basketId = basketId;

  String? getPaymentGroup() => paymentGroup;
  setPaymentGroup(String? paymentGroup) => this.paymentGroup = paymentGroup;

  double? getReward() => reward;
  setReward(double? reward) => this.reward = reward;

  PaymentCard? getPaymentCard() => paymentCard;
  setPaymentCard(PaymentCard? paymentCard) => this.paymentCard = paymentCard;

  Buyer? getBuyer() => buyer;
  setBuyer(Buyer? buyer) => this.buyer = buyer;

  Address? getShippingAddress() => shippingAddress;
  setShippingAddress(Address? shippingAddress) => this.shippingAddress = shippingAddress;

  Address? getBillingAddress() => billingAddress;
  setBillingAddress(Address? billingAddress) => this.billingAddress = billingAddress;

  List<BasketItem>? getBasketItems() => basketItems;
  setBasketItems(List<BasketItem>? basketItems) => this.basketItems = basketItems;

  String? getPaymentSource() => paymentSource;
  setPaymentSource(String? paymentSource) => this.paymentSource = paymentSource;

  String? getCurrency() => currency;
  setCurrency(String? currency) => this.currency = currency;

  String? getPosOrderId() => posOrderId;
  setPosOrderId(String? posOrderId) => this.posOrderId = posOrderId;

  String? getConnectorName() => connectorName;
  setConnectorName(String? connectorName) => this.connectorName = connectorName;

  bool? getPlusInstallmentUsage() => plusInstallmentUsage;
  setPlusInstallmentUsage(bool? plusInstallmentUsage) => this.plusInstallmentUsage = plusInstallmentUsage;

  String? getCallbackUrl() => callbackUrl;
  setCallbackUrl(String? callbackUrl) => this.callbackUrl = callbackUrl;

  // Methods to convert to JSON and PKI request string

  Map<String, dynamic> toJson() {

  return {
      'price': price,
      'paidPrice': paidPrice,
      'installment': installment,
      'paymentChannel': paymentChannel,
      'basketId': basketId,
      'paymentGroup': paymentGroup,
      'reward': reward,
      'paymentCard': paymentCard?.toJson(),
      'buyer': buyer?.toJson(),
      'shippingAddress': shippingAddress?.toJson(),
      'billingAddress': billingAddress?.toJson(),
      'basketItems': basketItems?.map((item) => item.toJson()).toList(),
      'paymentSource': paymentSource,
      'currency': currency,
      'posOrderId': posOrderId,
      'connectorName': connectorName,
      'plusInstallmentUsage': plusInstallmentUsage,
      'callbackUrl': callbackUrl,
    }
    ;
  }

  String toPKIRequestString() {
    final builder = RequestStringBuilder.create()
      ..appendSuper(super.toPKIRequestString())
      ..appendPrice('price', price)
      ..appendPrice('paidPrice', paidPrice)
      ..append('installment', installment)
      ..append('paymentChannel', paymentChannel)
      ..append('basketId', basketId)
      ..append('paymentGroup', paymentGroup)
      ..append('reward', reward)
      ..append('paymentCard', paymentCard?.toPKIRequestString())
      ..append('buyer', buyer?.toPKIRequestString())
      ..append('shippingAddress', shippingAddress?.toPKIRequestString())
      ..append('billingAddress', billingAddress?.toPKIRequestString())
      ..appendArray('basketItems', basketItems?.map((item) => item.toPKIRequestString()).toList())
      ..append('paymentSource', paymentSource)
      ..append('currency', currency)
      ..append('posOrderId', posOrderId)
      ..append('connectorName', connectorName)
      ..append('plusInstallmentUsage', plusInstallmentUsage)
      ..append('callbackUrl', callbackUrl);
    return builder.getRequestString();
  }
}
