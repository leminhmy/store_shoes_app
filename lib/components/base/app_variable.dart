import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppVariable{


  String numberFormatPriceVi(var price){
   String number =  NumberFormat.currency(
        locale: 'vi',symbol: 'đ', decimalDigits: 0
    ).format(price);

    return number;

  }
}