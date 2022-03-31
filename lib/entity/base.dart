import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../activity/home.dart';

class Base {
  static const String baseURL = 'http://172.27.80.1:';

  //static const String baseURL = 'http://172.31.171.123:'; // selçuk
// static const String baseURL = 'http://192.168.130.253:';
  void rotateHome(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void message(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
