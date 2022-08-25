import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SimpleConstants{
  static const String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";

  static String currencyFormat(double? value, {bool zeroIsEmpty = true}) {
    final oCcy = NumberFormat("#,###.##########", "en_US");
    var val = oCcy.format(value ?? 0);
    return val == "0" && zeroIsEmpty ? "" : val;
  }

  static String? dateToString(DateTime? date,
      {String format = 'yyyy-MM-dd HH:mm', bool returnNull = false}) {
    if (date == null) return returnNull ? null : "";
    final DateFormat formatter = DateFormat(format);
    final String formatted = formatter.format(date);
    return formatted;
  }


}