import 'package:flutter/material.dart';

class RequestFormatter {
  static String formatPrice(String price) {
    // Eğer fiyatın içinde nokta yoksa, ".0" ekler
    if (!price.contains('.')) {
      return '$price.0';
    }

    // Noktadan sonra gelen sıfırları temizler
    List<String> parts = price.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // Sıfırları temizlemek için ters çevirir ve işleme alır
    String reversedDecimalPart = decimalPart.split('').reversed.join();
    int firstNonZeroIndex = reversedDecimalPart.characters.toList().indexWhere((char) => char != '0');
    if (firstNonZeroIndex == -1) {
      // Sıfırların tamamı varsa
      decimalPart = '0';
    } else {
      decimalPart = reversedDecimalPart.substring(firstNonZeroIndex).split('').reversed.join();
    }

    // Fiyatı yeniden birleştirir
    return '$integerPart.$decimalPart';
  }
}
