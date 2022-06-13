import 'package:flutter/material.dart';

class CustomTextFieldHomeVisitWidget extends StatelessWidget {
  TextEditingController controller;
  String text;


  CustomTextFieldHomeVisitWidget(this.controller, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 119, 115, 112),
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 15,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            hintStyle: const TextStyle(color: Colors.black87),
            contentPadding: const EdgeInsets.all(16),
            hintText: text,
            fillColor: const Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }
}