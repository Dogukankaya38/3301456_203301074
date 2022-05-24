import 'package:flutter/material.dart';
import 'package:hospital_app/activity/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Card(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Expanded(
                flex: 58,
                child: Container(
                  margin: const EdgeInsets.only(top: 70),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset('assets/images/mainbackground.jpg'),
                  ),
                ),
              ),
              Expanded(
                flex: 35,
                child: Card(
                  color: Colors.white38,
                  shape: const RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(25))),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Sağlık Yardımcın!',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: "NotoSerif",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Tüm sağlık işlemlerini tek bir uygulamadan hallet.Online randevu alma, sağlık bilgilerine erişmek vb.. tüm özellikler elinin altında.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: "NotoSerif",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                            margin:
                                const EdgeInsets.only(top: 25, left: 50, right: 50),
                            width: double.infinity,
                            height: 50,
                            child: CustomButton())
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      onPressed: () {
        /* Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));*/
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LoginPage(),
          ),
          (route) => false,
        );
      },
      color: const Color.fromARGB(255, 137, 196, 192),
      child: const Text(
        'Başlayalım',
        style: TextStyle(color: Colors.black, fontSize: 17),
      ),
    );
  }
} // login sayfasına gider
