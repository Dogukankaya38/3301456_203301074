import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_app/const/base.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController textEditingIDController = TextEditingController();
TextEditingController textEditingPhoneNumberController =
    TextEditingController();
TextEditingController textEditingAddressController = TextEditingController();
TextEditingController textEditingSpecialCaseController =
    TextEditingController();

// ignore: use_key_in_widget_constructors
class HomeVisit extends StatelessWidget {
  // Yaşlı bakımı için eve doktar cağırır.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 119, 115, 112),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  Image.asset('assets/images/elderlycare.jpg'),
                  GestureDetector(
                    onTap: () {
                      Base().rotateHome(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Image.asset("assets/icons/previous.png",
                          width: 32, height: 32),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 7, right: 7, top: 15),
                child: const Text(
                  'Evde Sağlık Hizmetlerinden yararlanmak isteyen hasta veya hasta yakını Türkiye genelinde tahsis edilen 444 38 33 (444-EV DE) numaralı ulusal çağrı merkezini mesai saatleri içinde arayarak veya mobil uygulamadan kolaylıkla başvuruda bulunabilmektedir. Evde sağlık hizmetleri Sağlık bakanlığınca sunulmakta olup ücretsizdir.',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 15,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              CustomTextFieldIDNo(),
              CustomTextFieldPhoneNumber(),
              CustomTextFieldAddress(),
              CustomTextFieldSpecialCase(),
              CustomApplyButton(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class CustomTextFieldIDNo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 119, 115, 112),
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 15,
      ),
      child: TextField(
        controller: textEditingIDController,
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
            hintText: "Türkiye Cumhuriyeti Kimlik Numarası",
            fillColor: const Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class CustomTextFieldPhoneNumber extends StatelessWidget {
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
        controller: textEditingPhoneNumberController,
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
            hintText: "Telefon Numarası",
            fillColor: const Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class CustomTextFieldAddress extends StatelessWidget {
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
        controller: textEditingAddressController,
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
            hintText: "Ev Adresi",
            fillColor: const Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class CustomTextFieldSpecialCase extends StatelessWidget {
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
        controller: textEditingSpecialCaseController,
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
            hintText: "Hastalığı Veya Özel Durumu",
            fillColor: const Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class CustomApplyButton extends StatelessWidget {
  void apply(BuildContext context) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    // Await the http get response, then decode the json-formatted response.
    var body = jsonEncode({
      'id': textEditingIDController.text,
      'userName': sharedPreferences.getString("userName"), // burası değişecek
      'phoneNumber': textEditingPhoneNumberController.text,
      'address': textEditingAddressController.text,
      'specialCase': textEditingSpecialCaseController.text,
    });
    if (textEditingIDController.text.isEmpty ||
        textEditingPhoneNumberController.text.isEmpty ||
        textEditingAddressController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Lutfen alanları doldurunuz..",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    var response = await http.post(
        Uri.parse("${Base.baseURL}:8082/rest/home/visit"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: body);
    if (response.body == "successful") {
      print("apply is  Successful"); // kayıt yapıldı
      Fluttertoast.showToast(
          msg: "Başvurunuz Oluşturuldu....",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print(
          "There is already a registered user under this name."); // Bu isimle kayıtlı bir kullanıcı zaten var.
      Fluttertoast.showToast(
          msg: "Şuanda devam eden bir başvurunuz bulunmaktadır..",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 25, right: 25),
      height: 40,
      width: 225,
      child: RaisedButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        onPressed: () {
          apply(context);
        },
        color: const Color.fromARGB(255, 255, 255, 255),
        child: const Text(
          'Başvur',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: "NotoSerif",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
} // kullanıcı kaydını yapar
