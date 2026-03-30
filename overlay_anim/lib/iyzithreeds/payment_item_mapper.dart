import 'dart:convert';

// Assuming these classes are defined elsewhere
import 'payment_item.dart';
import 'converted_payout.dart';

class PaymentItemMapper {
  // Singleton pattern for creating an instance
  factory PaymentItemMapper() => _instance;

  factory PaymentItemMapper.create() => _instance;

  PaymentItemMapper._privateConstructor();
  static final PaymentItemMapper _instance = PaymentItemMapper._privateConstructor();

    List<PaymentItem> mapPaymentItems(List<dynamic> itemTransactions) {
    List<PaymentItem> paymentItems = [];

    for (var itemTransaction in itemTransactions) {
      final paymentItem = PaymentItem();

      if (itemTransaction['itemId'] != null) {
        paymentItem.itemId = itemTransaction['itemId'];
      }
      if (itemTransaction['paymentTransactionId'] != null) {
        paymentItem.paymentTransactionId = itemTransaction['paymentTransactionId'];
      }
      if (itemTransaction['transactionStatus'] != null) {
        paymentItem.transactionStatus = itemTransaction['transactionStatus'];
      }
      if (itemTransaction['price'] != null) {
        paymentItem.price = itemTransaction['price'].toDouble();
      }
      if (itemTransaction['paidPrice'] != null) {
        paymentItem.paidPrice = itemTransaction['paidPrice'].toDouble();
      }
      if (itemTransaction['merchantCommissionRate'] != null) {
        paymentItem.merchantCommissionRate = itemTransaction['merchantCommissionRate'].toDouble();
      }
      if (itemTransaction['merchantCommissionRateAmount'] != null) {
        paymentItem.merchantCommissionRateAmount = itemTransaction['merchantCommissionRateAmount'].toDouble();
      }
      if (itemTransaction['iyziCommissionRateAmount'] != null) {
        paymentItem.iyziCommissionRateAmount = itemTransaction['iyziCommissionRateAmount'].toDouble();
      }
      if (itemTransaction['iyziCommissionFee'] != null) {
        paymentItem.iyziCommissionFee = itemTransaction['iyziCommissionFee'].toDouble();
      }
      if (itemTransaction['blockageRate'] != null) {
        paymentItem.blockageRate = itemTransaction['blockageRate'].toDouble();
      }
      if (itemTransaction['blockageRateAmountMerchant'] != null) {
        paymentItem.blockageRateAmountMerchant = itemTransaction['blockageRateAmountMerchant'].toDouble();
      }
      if (itemTransaction['blockageRateAmountSubMerchant'] != null) {
        paymentItem.blockageRateAmountSubMerchant = itemTransaction['blockageRateAmountSubMerchant'].toDouble();
      }
      if (itemTransaction['blockageResolvedDate'] != null) {
        paymentItem.blockageResolvedDate = itemTransaction['blockageResolvedDate'];
      }
      if (itemTransaction['subMerchantKey'] != null) {
        paymentItem.subMerchantKey = itemTransaction['subMerchantKey'];
      }
      if (itemTransaction['subMerchantPrice'] != null) {
        paymentItem.subMerchantPrice = itemTransaction['subMerchantPrice'].toDouble();
      }
      if (itemTransaction['subMerchantPayoutRate'] != null) {
        paymentItem.subMerchantPayoutRate = itemTransaction['subMerchantPayoutRate'].toDouble();
      }
      if (itemTransaction['subMerchantPayoutAmount'] != null) {
        paymentItem.subMerchantPayoutAmount = itemTransaction['subMerchantPayoutAmount'].toDouble();
      }
      if (itemTransaction['merchantPayoutAmount'] != null) {
        paymentItem.merchantPayoutAmount = itemTransaction['merchantPayoutAmount'].toDouble();
      }
      if (itemTransaction['convertedPayout'] != null) {
        paymentItem.convertedPayout = mapConvertedPayout(itemTransaction['convertedPayout']);
      }

      paymentItems.add(paymentItem);
    }

    return paymentItems;
  }

  ConvertedPayout mapConvertedPayout(dynamic payout) {
    final convertedPayout = ConvertedPayout();

    if (payout['paidPrice'] != null) {
      convertedPayout.paidPrice = payout['paidPrice'].toDouble();
    }
    if (payout['iyziCommissionRateAmount'] != null) {
      convertedPayout.iyziCommissionRateAmount = payout['iyziCommissionRateAmount'].toDouble();
    }
    if (payout['iyziCommissionFee'] != null) {
      convertedPayout.iyziCommissionFee = payout['iyziCommissionFee'].toDouble();
    }
    if(payout['blockageRateAmountMerchant'] != null) {
      convertedPayout.blockageRateAmountMerchant = payout['blockageRateAmountMerchant'].toDouble();
    }
if(payout['blockageRateAmountSubMerchant'] != null) {
      convertedPayout.blockageRateAmountSubMerchant = payout['blockageRateAmountSubMerchant'].toDouble();
    }
if(payout['subMerchantPayoutAmount'] != null) {
      convertedPayout.subMerchantPayoutAmount = payout['subMerchantPayoutAmount'].toDouble();
    }
if(payout['merchantPayoutAmount'] != null) {
      convertedPayout.merchantPayoutAmount = payout['merchantPayoutAmount'].toDouble();
    }
if(payout['iyziConversionRate'] != null) {
      convertedPayout.iyziConversionRate = payout['iyziConversionRate'].toDouble();
    }
if(payout['iyziConversionRateAmount'] != null) {
      convertedPayout.iyziConversionRateAmount = payout['iyziConversionRateAmount'].toDouble();
    }
if(payout['currency'] != null) {
      convertedPayout.currency = payout['currency'];
    }
    return convertedPayout;  
  
  }

}
