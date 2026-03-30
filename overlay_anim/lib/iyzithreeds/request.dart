import 'dart:convert';

import 'base_model.dart';
import 'json_builder.dart';
import 'request_string_builder.dart';

class Request extends BaseModel {
  String? locale;
  String? conversationId;
  String? paymentId;
  String? paymentConversationId;
  String? transactionDate;
  int? page;
  int? count;
  String? productReferenceCode;
  String? subscriptionReferenceCode;
  String? parentReferenceCode;
  String? customerReferenceCode;
  String? pricingPlanReferenceCode;
  String? subscriptionStatus;
  String? startDate;
  String? endDate;


  String? getEndDate(){
    return endDate;
  }

  setEndDate(endDate){
    this.endDate = endDate;
  }


  String? getStartDate(){
    return startDate;
  }

  setStartDate(startDate){
    this.startDate = startDate;
  }


  String? getSubscriptionStatus(){
    return subscriptionStatus;
  }

  setSubscriptionStatus(subscriptionStatus){
    this.subscriptionStatus = subscriptionStatus;
  }

    
    String? getPricingPlanReferenceCode()
    {
        return pricingPlanReferenceCode;
    }

    setPricingPlanReferenceCode(pricingPlanReferenceCode)
    {
     this.pricingPlanReferenceCode = pricingPlanReferenceCode;
    }



    String? getCustomerReferenceCode()
    {
        return customerReferenceCode;
    }

    setCustomerReferenceCode(customerReferenceCode) {
     this.customerReferenceCode = customerReferenceCode;
    }




    String? getParentReferenceCode()
    {
        return parentReferenceCode;
    }

    setParentReverenceCode(parentReferenceCode)
    {
     this.parentReferenceCode = parentReferenceCode;
    }


    String? getSubscriptionReferenceCode()
    {
        return subscriptionReferenceCode;
    }

    setSubscriptionReferenceCode(subscriptionReferenceCode)
    {
     this.subscriptionReferenceCode = subscriptionReferenceCode;
    }


  int? getCount() {
    return count;
  }

  void setCount(int count) {
    this.count = count;
  }

  String? getProductReferenceCode() {
    return productReferenceCode;
  }

  void setProductReferenceCode(String productReferenceCode) {
    this.productReferenceCode = productReferenceCode;
  }

  // Getter metotları
  String? getTransactionDate() {
    return transactionDate;
  }

  void setTransactionDate(String transactionDate) {
    this.transactionDate = transactionDate;
  }

  int? getPage() {
    return page;
  }

  void setPage(int page) {
    this.page = page;
  }


  String? getLocale() => locale;
  void setLocale(String? locale) => this.locale = locale;

   String? getConversationId() => conversationId;
   void setConversationId(String? conversationId) => this.conversationId = conversationId;

  Map<String, dynamic> getJsonObject() {
    final jsonBuilder = JsonBuilder.create();
    if (locale != null) {
      jsonBuilder.add('locale', locale);
    }
    if (conversationId != null) {
      jsonBuilder.add('conversationId', conversationId);
    }
    if (paymentId != null) {
      jsonBuilder.add('paymentId', paymentId);
    }
    if (paymentConversationId != null) {
      jsonBuilder.add('paymentConversationId', paymentConversationId);
    }
    if (transactionDate != null) {
      jsonBuilder.add('transactionDate', transactionDate);
    }
    if (page != null) {
      jsonBuilder.add('page', page);
    }
    return jsonBuilder.getObject();
  }




  String toPKIRequestString() {
    final requestStringBuilder = RequestStringBuilder.create();
    if (locale != null) {
      requestStringBuilder.append('locale', locale);
    }
    if (conversationId != null) {
      requestStringBuilder.append('conversationId', conversationId);
    }
    if (paymentId != null) {
      requestStringBuilder.append('paymentId', paymentId);
    }
    if (paymentConversationId != null) {
      requestStringBuilder.append('paymentConversationId', paymentConversationId);
    }

    return requestStringBuilder.getRequestString();
  }
  




  @override
  String toRequestString() {
    throw UnimplementedError();
  }


String? getPaymentId() {
    return paymentId;
  }

  // Setter metodu
  void setPaymentId(String paymentId) {
    this.paymentId = paymentId;
  }

  // Getter metodu
  String? getPaymentConversationId() {
    return paymentConversationId;
  }

  // Setter metodu
  void setPaymentConversationId(String paymentConversationId) {
    this.paymentConversationId = paymentConversationId;
  }



}
