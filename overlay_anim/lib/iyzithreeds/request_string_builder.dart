import 'request_string_convertable.dart';
import '../iyzithreeds/request.dart';
import 'request_formatter.dart';

class RequestStringBuilder {
  String requestString;

  RequestStringBuilder(this.requestString);

  factory RequestStringBuilder.create() {
    return RequestStringBuilder('');
  }

  RequestStringBuilder appendSuper(String? superRequestString) {
    if (superRequestString != null) {
      superRequestString = superRequestString.substring(1, superRequestString.length - 1);
      if (superRequestString.isNotEmpty) {
        requestString = '$requestString$superRequestString,';
      }
    }
    return this;
  }

  RequestStringBuilder append(String key, dynamic value) {
    if (value != null) {
      if (value is RequestStringConvertible) {
        appendKeyValue(key, (value as RequestStringConvertible).toPKIRequestString());
      } else {
        appendKeyValue(key, value);
      }
    }
    return this;
  }

  RequestStringBuilder appendPrice(String key, dynamic value) {
    if (value != null) {
      appendKeyValue(key, RequestFormatter.formatPrice(value));
    }
    return this;
  }

  RequestStringBuilder appendArray(String key, List<dynamic>? array) {
    if (array != null) {
      String appendedValue = '';
      for (var value in array) {
        if (value is RequestStringConvertible) {
          appendedValue += (value as RequestStringConvertible).toPKIRequestString();
        } else {
          appendedValue += value.toString();
        }
        appendedValue += ', ';
      }
      appendKeyValueArray(key, appendedValue);
    }
    return this;
  }

  void appendKeyValue(String key, dynamic value) {
    if (value != null) {
      requestString += '$key=$value,';
    }
  }

  void appendKeyValueArray(String key, String value) {
    if (value.isNotEmpty) {
      value = value.substring(0, value.length - 2);
      requestString += '$key=[$value],';
    }
  }

  RequestStringBuilder appendPrefix() {
    requestString = '[$requestString]';
    return this;
  }

  RequestStringBuilder removeTrailingComma() {
    if (requestString.isNotEmpty) {
      requestString = requestString.substring(0, requestString.length - 1);
    }
    return this;
  }

  String getRequestString() {
    removeTrailingComma();
    appendPrefix();
    return requestString;
  }


  

  static String requestToStringQuery(Request request, [String? type]) {
    String? stringQuery;

    if (request.getConversationId() != null) {
      stringQuery = '?conversationId=${request.getConversationId()}';
    }

    if (request.getLocale() != null) {
      stringQuery = stringQuery == null ? '?locale=${request.getLocale()}' : '$stringQuery&locale=${request.getLocale()}';
    }

    if (type == 'defaultParams') {
      if (request.getConversationId() != null) {
        stringQuery = '?conversationId=${request.getConversationId()}';
        if (request.getLocale() != null) {
          stringQuery += '&locale=${request.getLocale()}';
        }
      } else {
        if (request.getLocale() != null) {
          stringQuery = '?locale=${request.getLocale()}';
        }
      }
    }

    if (type == 'reporting') {
      if (request.getPaymentConversationId() != null) {
        stringQuery = '?paymentConversationId=${request.getPaymentConversationId()}';
      }
    }

    if (type == 'reportingTransaction') {
      if (request.transactionDate != null) {
        stringQuery = stringQuery == null ? '?transactionDate=${request.getTransactionDate()}' : '$stringQuery&transactionDate=${request.getTransactionDate()}';
      }
      if (request.getPage() != null) {
        stringQuery = stringQuery == null ? '?page=${request.getPage()}' : '$stringQuery&page=${request.getPage()}';
      }
    }

    

    if (type == 'subscriptionItems') {
      if (request.page != null) {
        stringQuery = '?page=${request.getPage()}';
      }
      if (request.getCount() != null) {
        stringQuery = stringQuery == null ? '?count=${request.getCount()}' : '$stringQuery&count=${request.getCount()}';
      }
      if (request.getConversationId() != null) {
        stringQuery = stringQuery == null ? '?conversationId=${request.getConversationId()}' : '$stringQuery&conversationId=${request.getConversationId()}';
      }
      if (request.getLocale() != null) {
        stringQuery = stringQuery == null ? '?locale=${request.getLocale()}' : '$stringQuery&locale=${request.getLocale()}';
      }
    }

    if (type == 'searchSubscription') {
      if (request.getPage() != null) {
        stringQuery = '?page=${request.getPage()}';
      }
      if (request.getCount() != null) {
        stringQuery = stringQuery == null ? '?count=${request.getCount()}' : '$stringQuery&count=${request.getCount()}';
      }
      if (request.getSubscriptionReferenceCode() != null) {
        stringQuery = stringQuery == null ? '?subscriptionReferenceCode=${request.getSubscriptionReferenceCode()}' : '$stringQuery&subscriptionReferenceCode=${request.getSubscriptionReferenceCode()}';
      }
      if (request.getParentReferenceCode() != null) {
        stringQuery = stringQuery == null ? '?parentReferenceCode=${request.getParentReferenceCode()}' : '$stringQuery&parentReferenceCode=${request.getParentReferenceCode()}';
      }
      if (request.getCustomerReferenceCode() != null) {
        stringQuery = stringQuery == null ? '?customerReferenceCode=${request.getCustomerReferenceCode()}' : '$stringQuery&customerReferenceCode=${request.getCustomerReferenceCode()}';
      }
      if (request.getPricingPlanReferenceCode() != null) {
        stringQuery = stringQuery == null ? '?pricingPlanReferenceCode=${request.getPricingPlanReferenceCode()}' : '$stringQuery&pricingPlanReferenceCode=${request.getPricingPlanReferenceCode()}';
      }
      if (request.getSubscriptionStatus() != null) {
        stringQuery = stringQuery == null ? '?subscriptionStatus=${request.getSubscriptionStatus()}' : '$stringQuery&subscriptionStatus=${request.getSubscriptionStatus()}';
      }
      if (request.getStartDate() != null) {
        stringQuery = stringQuery == null ? '?startDate=${request.getStartDate()}' : '$stringQuery&startDate=${request.getStartDate()}';
      }
      if (request.getEndDate() != null) {
        stringQuery = stringQuery == null ? '?endDate=${request.getEndDate()}' : '$stringQuery&endDate=${request.getEndDate()}';
      }
      if (request.getConversationId() != null) {
        stringQuery = stringQuery == null ? '?conversationId=${request.getConversationId()}' : '$stringQuery&conversationId=${request.getConversationId()}';
      }
      if (request.getLocale() != null) {
        stringQuery = stringQuery == null ? '?locale=${request.getLocale()}' : '$stringQuery&locale=${request.getLocale()}';
      }
    }

    if (type == 'pages') {
      if (request.getPage() != null) {
        stringQuery = stringQuery == null ? '?page=${request.getPage()}' : '$stringQuery&page=${request.getPage()}';
      }
      if (request.getCount() != null) {
        stringQuery = stringQuery == null ? '?count=${request.getCount()}' : '$stringQuery&count=${request.getCount()}';
      }
    }

    return stringQuery ?? '';
  }
}
