import 'package:flutter/material.dart';

Widget titleWidget(title, subtitle, color) {
  return ListTile(
    title: Text(title,
        style: TextStyle(
            color: color, fontSize: 17, fontWeight: FontWeight.w500)),
    trailing: Text(subtitle, style: TextStyle(color: color, fontSize: 14)),
  );
}