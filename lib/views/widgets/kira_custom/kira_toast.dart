import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KiraToast {
  static void show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      textColor: Colors.black,
      webBgColor: '#fff',
      webPosition: 'center',
      fontSize: 16,
    );
  }
}
