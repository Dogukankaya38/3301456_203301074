import 'package:flutter/material.dart';

import '../activity/covid.dart';

class GetMoreInformationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: const Text(
        'Daha Fazla Bilgi Al',
        style: TextStyle(
          color: Colors.black87,
          fontSize: 12,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => covid()));
      },
    );
  }
} // Covid 19 sayfasına gider
