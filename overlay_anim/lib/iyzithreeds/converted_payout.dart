class ConvertedPayout {
  double? paidPrice;
  double? iyziCommissionRateAmount;
  double? iyziCommissionFee;
  double? blockageRateAmountMerchant;
  double? blockageRateAmountSubMerchant;
  double? subMerchantPayoutAmount;
  double? merchantPayoutAmount;
  double? iyziConversionRate;
  double? iyziConversionRateAmount;
  String? currency;

  // Getter ve setter metotları
  double? getPaidPrice() {
    return paidPrice;
  }

  void setPaidPrice(double paidPrice) {
    this.paidPrice = paidPrice;
  }

  double? getIyziCommissionRateAmount() {
    return iyziCommissionRateAmount;
  }

  void setIyziCommissionRateAmount(double iyziCommissionRateAmount) {
    this.iyziCommissionRateAmount = iyziCommissionRateAmount;
  }

  double? getIyziCommissionFee() {
    return iyziCommissionFee;
  }

  void setIyziCommissionFee(double iyziCommissionFee) {
    this.iyziCommissionFee = iyziCommissionFee;
  }

  double? getBlockageRateAmountMerchant() {
    return blockageRateAmountMerchant;
  }

  void setBlockageRateAmountMerchant(double blockageRateAmountMerchant) {
    this.blockageRateAmountMerchant = blockageRateAmountMerchant;
  }

  double? getBlockageRateAmountSubMerchant() {
    return blockageRateAmountSubMerchant;
  }

  void setBlockageRateAmountSubMerchant(double blockageRateAmountSubMerchant) {
    this.blockageRateAmountSubMerchant = blockageRateAmountSubMerchant;
  }

  double? getSubMerchantPayoutAmount() {
    return subMerchantPayoutAmount;
  }

  void setSubMerchantPayoutAmount(double subMerchantPayoutAmount) {
    this.subMerchantPayoutAmount = subMerchantPayoutAmount;
  }

  double? getMerchantPayoutAmount() {
    return merchantPayoutAmount;
  }

  void setMerchantPayoutAmount(double merchantPayoutAmount) {
    this.merchantPayoutAmount = merchantPayoutAmount;
  }

  double? getIyziConversionRate() {
    return iyziConversionRate;
  }

  void setIyziConversionRate(double iyziConversionRate) {
    this.iyziConversionRate = iyziConversionRate;
  }

  double? getIyziConversionRateAmount() {
    return iyziConversionRateAmount;
  }

  void setIyziConversionRateAmount(double iyziConversionRateAmount) {
    this.iyziConversionRateAmount = iyziConversionRateAmount;
  }

  String? getCurrency() {
    return currency;
  }

  void setCurrency(String currency) {
    this.currency = currency;
  }

  ConvertedPayout();

  factory ConvertedPayout.fromJson(Map<String, dynamic> json) {
    return ConvertedPayout()
      ..paidPrice = json['paidPrice']
      ..iyziCommissionRateAmount = json['iyziCommissionRateAmount']
      ..iyziCommissionFee = json['iyziCommissionFee']
      ..blockageRateAmountMerchant = json['blockageRateAmountMerchant']
      ..blockageRateAmountSubMerchant = json['blockageRateAmountSubMerchant']
      ..subMerchantPayoutAmount = json['subMerchantPayoutAmount']
      ..merchantPayoutAmount = json['merchantPayoutAmount']
      ..iyziConversionRate = json['iyziConversionRate']
      ..iyziConversionRateAmount = json['iyziConversionRateAmount']
      ..currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paidPrice'] = paidPrice;
    data['iyziCommissionRateAmount'] = iyziCommissionRateAmount;
    data['iyziCommissionFee'] = iyziCommissionFee;
    data['blockageRateAmountMerchant'] = blockageRateAmountMerchant;
    data['blockageRateAmountSubMerchant'] = blockageRateAmountSubMerchant;
    data['subMerchantPayoutAmount'] = subMerchantPayoutAmount;
    data['merchantPayoutAmount'] = merchantPayoutAmount;
    data['iyziConversionRate'] = iyziConversionRate;
    data['iyziConversionRateAmount'] = iyziConversionRateAmount;
    data['currency'] = currency;
    return data;
  }
}
