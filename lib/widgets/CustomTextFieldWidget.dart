
import 'package:flutter/material.dart';

class CustomTextFieldRegisterWidget extends StatelessWidget {
  TextEditingController controller;
  String text;
  bool obscure;
  Color color;

  CustomTextFieldRegisterWidget(
      this.controller, this.text, this.obscure, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 17,
      ),
      child: TextField(
        obscureText: obscure,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: "NotoSerif",
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            hintStyle: const TextStyle(color: Colors.black87),
            contentPadding: const EdgeInsets.all(16),
            hintText: text,
            fillColor: color),
      ),
    );
  }
}
