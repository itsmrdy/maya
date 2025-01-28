import 'dart:convert';
import 'package:intl/intl.dart';
import '../valueobjects/maya_auth_user_dto.dart';

extension StringExtension on String {
  toNumberFormat() {
    final num = this;
    return NumberFormat.currency(locale: "en_PH", symbol: '₱')
        .format(double.parse(num));
  }

  toUserEntity() {
    // Replace the keys and string values with double quotes to make it valid JSON
    // Attempt to manually parse the string to JSON using a regular expression
    
    return MayaAuthUserDto.fromJson(json.decode(this)).toEntity();
  }
}
