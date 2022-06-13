import 'package:flutter/material.dart';

import '../activity/register.dart';

class CustomRegisterRotate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 17, left: 40, right: 40),
      height: 50,
      child: RaisedButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        },
        color: const Color.fromARGB(255, 89, 89, 81),
        child: const Text(
          'Kaydol',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: "NotoSerif",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
} // kullanıcı kayıt sayfasına gider
