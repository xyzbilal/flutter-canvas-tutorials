import 'package:overlay_anim/iyzithreeds/converted_payout.dart';

class PaymentItem {
  String? _itemId;
  String? _paymentTransactionId;
  String? _transactionStatus;
  double? _price;
  double? _paidPrice;
  double? _merchantCommissionRate;
  double? _merchantCommissionRateAmount;
  double? _iyziCommissionRateAmount;
  double? _iyziCommissionFee;
  double? _blockageRate;
  double? _blockageRateAmountMerchant;
  double? _blockageRateAmountSubMerchant;
  DateTime? _blockageResolvedDate; // Adjust type as needed
  String? _subMerchantKey;
  double? _subMerchantPrice;
  double? _subMerchantPayoutRate;
  double? _subMerchantPayoutAmount;
  double? _merchantPayoutAmount;
  ConvertedPayout? _convertedPayout;

  PaymentItem();

  // Getters and setters
  String? get itemId => _itemId;
  set itemId(String? itemId) => _itemId = itemId;

  String? get paymentTransactionId => _paymentTransactionId;
  set paymentTransactionId(String? paymentTransactionId) => _paymentTransactionId = paymentTransactionId;

  String? get transactionStatus => _transactionStatus;
  set transactionStatus(String? transactionStatus) => _transactionStatus = transactionStatus;

  double? get price => _price;
  set price(double? price) => _price = price;

  double? get paidPrice => _paidPrice;
  set paidPrice(double? paidPrice) => _paidPrice = paidPrice;

  double? get merchantCommissionRate => _merchantCommissionRate;
  set merchantCommissionRate(double? rate) => _merchantCommissionRate = rate;

  double? get merchantCommissionRateAmount => _merchantCommissionRateAmount;
  set merchantCommissionRateAmount(double? amount) => _merchantCommissionRateAmount = amount;

  double? get iyziCommissionRateAmount => _iyziCommissionRateAmount;
  set iyziCommissionRateAmount(double? amount) => _iyziCommissionRateAmount = amount;

  double? get iyziCommissionFee => _iyziCommissionFee;
  set iyziCommissionFee(double? fee) => _iyziCommissionFee = fee;

  double? get blockageRate => _blockageRate;
  set blockageRate(double? rate) => _blockageRate = rate;

  double? get blockageRateAmountMerchant => _blockageRateAmountMerchant;
  set blockageRateAmountMerchant(double? amount) => _blockageRateAmountMerchant = amount;

  double? get blockageRateAmountSubMerchant => _blockageRateAmountSubMerchant;
  set blockageRateAmountSubMerchant(double? amount) => _blockageRateAmountSubMerchant = amount;

  DateTime? get blockageResolvedDate => _blockageResolvedDate;
  set blockageResolvedDate(DateTime? date) => _blockageResolvedDate = date;

  String? get subMerchantKey => _subMerchantKey;
  set subMerchantKey(String? key) => _subMerchantKey = key;

  double? get subMerchantPrice => _subMerchantPrice;
  set subMerchantPrice(double? price) => _subMerchantPrice = price;

  double? get subMerchantPayoutRate => _subMerchantPayoutRate;
  set subMerchantPayoutRate(double? rate) => _subMerchantPayoutRate = rate;

  double? get subMerchantPayoutAmount => _subMerchantPayoutAmount;
  set subMerchantPayoutAmount(double? amount) => _subMerchantPayoutAmount = amount;

  double? get merchantPayoutAmount => _merchantPayoutAmount;
  set merchantPayoutAmount(double? amount) => _merchantPayoutAmount = amount;

  ConvertedPayout? get convertedPayout => _convertedPayout;

  set convertedPayout(ConvertedPayout? payout) => _convertedPayout = payout;

  factory PaymentItem.fromJson(Map<String, dynamic> json) {
    return PaymentItem()
      ..itemId = json['itemId']
      ..paymentTransactionId = json['paymentTransactionId']
      ..transactionStatus = json['transactionStatus']
      ..price = json['price']
      ..paidPrice = json['paidPrice']
      ..merchantCommissionRate = json['merchantCommissionRate']
      ..merchantCommissionRateAmount = json['merchantCommissionRateAmount']
      ..iyziCommissionRateAmount = json['iyziCommissionRateAmount']
      ..iyziCommissionFee = json['iyziCommissionFee']
      ..blockageRate = json['blockageRate']
      ..blockageRateAmountMerchant = json['blockageRateAmountMerchant']
      ..blockageRateAmountSubMerchant = json['blockageRateAmountSubMerchant']
      ..blockageResolvedDate = DateTime.tryParse(json['blockageResolvedDate'])
      ..subMerchantKey = json['subMerchantKey']
      ..subMerchantPrice = json['subMerchantPrice']
      ..subMerchantPayoutRate = json['subMerchantPayoutRate']
      ..subMerchantPayoutAmount = json['subMerchantPayoutAmount']
      ..merchantPayoutAmount = json['merchantPayoutAmount']
      ..convertedPayout = json['convertedPayout'];
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': _itemId,
      'paymentTransactionId': _paymentTransactionId,
      'transactionStatus': _transactionStatus,
      'price': _price,
      'paidPrice': _paidPrice,
      'merchantCommissionRate': _merchantCommissionRate,
      'merchantCommissionRateAmount': _merchantCommissionRateAmount,
      'iyziCommissionRateAmount': _iyziCommissionRateAmount,
      'iyziCommissionFee': _iyziCommissionFee,
      'blockageRate': _blockageRate,
      'blockageRateAmountMerchant': _blockageRateAmountMerchant,
      'blockageRateAmountSubMerchant': _blockageRateAmountSubMerchant,
      'blockageResolvedDate': _blockageResolvedDate?.toIso8601String(),
      'subMerchantKey': _subMerchantKey,
      'subMerchantPrice': _subMerchantPrice,
      'subMerchantPayoutRate': _subMerchantPayoutRate,
      'subMerchantPayoutAmount': _subMerchantPayoutAmount,
      'merchantPayoutAmount': _merchantPayoutAmount,
      'convertedPayout': _convertedPayout?.toJson(),
    };
  }

}
