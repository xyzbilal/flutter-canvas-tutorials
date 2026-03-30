


import 'request.dart';

class CreatePaymentRequest extends Request{

  String price;
  String paidPrice;
  String currency;
  int installment;
  String basketId;
  String paymentChannel;
  String paymentGroup;
  String callbackUrl;
  PaymentCard paymentCard;
  Buyer buyer;
  Address shippingAddress;
  Address billingAddress;
  List<BasketItem> basketItems;

  CreatePaymentRequest({
    required this.price,
    required this.paidPrice,
    required this.currency,
    required this.installment,
    required this.basketId,
    required this.paymentChannel,
    required this.paymentGroup,
    required this.callbackUrl,
    required this.paymentCard,
    required this.buyer,
    required this.shippingAddress,
    required this.billingAddress,
    required this.basketItems,
  });

  factory CreatePaymentRequest.fromJson(Map<String, dynamic> json) {
    return CreatePaymentRequest(
      price: json['price'],
      paidPrice: json['paidPrice'],
      currency: json['currency'],
      installment: json['installment'],
      basketId: json['basketId'],
      paymentChannel: json['paymentChannel'],
      paymentGroup: json['paymentGroup'],
      callbackUrl: json['callbackUrl'],
      paymentCard: PaymentCard.fromJson(json['paymentCard']),
      buyer: Buyer.fromJson(json['buyer']),
      shippingAddress: Address.fromJson(json['shippingAddress']),
      billingAddress: Address.fromJson(json['billingAddress']),
      basketItems: List<BasketItem>.from(json['basketItems'].map((item) => BasketItem.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locale': locale,
      'conversationId': conversationId,
      'price': price,
      'paidPrice': paidPrice,
      'currency': currency,
      'installment': installment,
      'basketId': basketId,
      'paymentChannel': paymentChannel,
      'paymentGroup': paymentGroup,
      'callbackUrl': callbackUrl,
      'paymentCard': paymentCard.toJson(),
      'buyer': buyer.toJson(),
      'shippingAddress': shippingAddress.toJson(),
      'billingAddress': billingAddress.toJson(),
      'basketItems': List<dynamic>.from(basketItems.map((item) => item.toJson())),
    };
  }
}

class PaymentCard extends Request{
  String cardHolderName;
  String cardNumber;
  String expireMonth;
  String expireYear;
  String cvc;
  int registerCard;

  PaymentCard({
    required this.cardHolderName,
    required this.cardNumber,
    required this.expireMonth,
    required this.expireYear,
    required this.cvc,
    required this.registerCard,
  });

  factory PaymentCard.fromJson(Map<String, dynamic> json) {
    return PaymentCard(
      cardHolderName: json['cardHolderName'],
      cardNumber: json['cardNumber'],
      expireMonth: json['expireMonth'],
      expireYear: json['expireYear'],
      cvc: json['cvc'],
      registerCard: json['registerCard'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'expireMonth': expireMonth,
      'expireYear': expireYear,
      'cvc': cvc,
      'registerCard': registerCard,
    };
  }
}

class Buyer extends Request{
  String id;
  String name;
  String surname;
  String gsmNumber;
  String email;
  String identityNumber;
  String lastLoginDate;
  String registrationDate;
  String registrationAddress;
  String ip;
  String city;
  String country;
  String zipCode;

  Buyer({
    required this.id,
    required this.name,
    required this.surname,
    required this.gsmNumber,
    required this.email,
    required this.identityNumber,
    required this.lastLoginDate,
    required this.registrationDate,
    required this.registrationAddress,
    required this.ip,
    required this.city,
    required this.country,
    required this.zipCode,
  });

  factory Buyer.fromJson(Map<String, dynamic> json) {
    return Buyer(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      gsmNumber: json['gsmNumber'],
      email: json['email'],
      identityNumber: json['identityNumber'],
      lastLoginDate: json['lastLoginDate'],
      registrationDate: json['registrationDate'],
      registrationAddress: json['registrationAddress'],
      ip: json['ip'],
      city: json['city'],
      country: json['country'],
      zipCode: json['zipCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'gsmNumber': gsmNumber,
      'email': email,
      'identityNumber': identityNumber,
      'lastLoginDate': lastLoginDate,
      'registrationDate': registrationDate,
      'registrationAddress': registrationAddress,
      'ip': ip,
      'city': city,
      'country': country,
      'zipCode': zipCode,
    };
  }
}

class Address extends Request{
  String contactName;
  String city;
  String country;
  String address;
  String zipCode;

  Address({
    required this.contactName,
    required this.city,
    required this.country,
    required this.address,
    required this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      contactName: json['contactName'],
      city: json['city'],
      country: json['country'],
      address: json['address'],
      zipCode: json['zipCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contactName': contactName,
      'city': city,
      'country': country,
      'address': address,
      'zipCode': zipCode,
    };
  }
}

class BasketItem extends Request{
  String id;
  String name;
  String category1;
  String category2;
  String itemType;
  String price;

  BasketItem({
    required this.id,
    required this.name,
    required this.category1,
    required this.category2,
    required this.itemType,
    required this.price,
  });

  factory BasketItem.fromJson(Map<String, dynamic> json) {
    return BasketItem(
      id: json['id'],
      name: json['name'],
      category1: json['category1'],
      category2: json['category2'],
      itemType: json['itemType'],
      price: json['price'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category1': category1,
      'category2': category2,
      'itemType': itemType,
      'price': price,
    };
  }
}
