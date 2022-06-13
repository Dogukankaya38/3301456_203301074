// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_app/activity/home.dart';
import 'package:hospital_app/const/base.dart';
import 'package:hospital_app/widgets/CustomTextFieldWidget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController controllerUserName2 = TextEditingController();
TextEditingController controllerPassword2 = TextEditingController();
TextEditingController controllerEmail2 = TextEditingController();
TextEditingController controllerBloodGroup = TextEditingController();
TextEditingController controllerWeightGroup = TextEditingController();
TextEditingController controllerHeightGroup = TextEditingController();

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: Card(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  flex: 60,
                  child: Container(
                    margin: const EdgeInsets.only(top: 70),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset('assets/images/register.png'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 70,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CustomTextFieldRegisterWidget(
                              controllerUserName2,
                              "Kullanıcı Adı",
                              false,
                              const Color.fromARGB(255, 98, 210, 248)),
                          CustomTextFieldRegisterWidget(
                              controllerPassword2,
                              "Şifre",
                              true,
                              const Color.fromARGB(255, 98, 210, 248)),
                          CustomTextFieldRegisterWidget(
                              controllerEmail2,
                              "Email",
                              false,
                              const Color.fromARGB(255, 98, 210, 248)),
                          CustomTextFieldRegisterWidget(
                              controllerBloodGroup,
                              "Kan Grubu",
                              false,
                              const Color.fromARGB(255, 98, 210, 248)),
                          Row(children: [
                            Expanded(
                                child: CustomTextFieldRegisterWidget(
                                    controllerWeightGroup,
                                    "Kilo",
                                    false,
                                    const Color.fromARGB(255, 98, 210, 248))),
                            Expanded(
                                child: CustomTextFieldRegisterWidget(
                                    controllerHeightGroup,
                                    "Boy",
                                    false,
                                    const Color.fromARGB(255, 98, 210, 248)))
                          ]),
                          CustomRegister(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} // kayıt olma sayfası

class CustomRegister extends StatelessWidget {
  void getLogin(BuildContext context) async {
    if (!controllerEmail2.text.contains("@")) {
      Base().message(
          "E posta adresiniz hastanekayıt@flutter.app şeklinde olmasına dikket ediniz.");
    }
    var sharedPreferences = await SharedPreferences.getInstance();
    if (controllerUserName2.text.isEmpty ||
        controllerPassword2.text.isEmpty ||
        controllerEmail2.text.isEmpty) {
      return;
    }
    // Await the http get response, then decode the json-formatted response.
    var body = jsonEncode({
      'userName': controllerUserName2.text,
      'password': controllerPassword2.text,
      'email': controllerEmail2.text,
      'blood': controllerBloodGroup.text,
      'weight': controllerWeightGroup.text,
      'height': controllerHeightGroup.text,
      'grade': "user"
    });

    var response = await http.post(
        Uri.parse("${Base.baseURL}8080/rest/authentication/register"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: body);
    if (response.body == "Recorded.") {
      sharedPreferences.setString("userName", controllerUserName2.text);
      sharedPreferences.setString("password", controllerPassword2.text);
      sharedPreferences.setBool("isTrue", false);
      print("Registration Successful"); // kayıt yapıldı
      Fluttertoast.showToast(
          msg: "Kaydınız Oluşturuldu....",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
        (route) => false,
      );
    } else {
      print(
          "There is already a registered user under this name."); // Bu isimle kayıtlı bir kullanıcı zaten var.
      Fluttertoast.showToast(
          msg: "Bu isimle kayıtlı bir kullanıcı zaten var",
          toastLength: Toast.LENGTH_SHORT,
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
      width: double.infinity,
      margin: const EdgeInsets.only(top: 17, left: 40, right: 40),
      height: 50,
      child: RaisedButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        onPressed: () {
          getLogin(context);
        },
        color: const Color.fromARGB(255, 98, 210, 248),
        child: const Text(
          'Kaydol',
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
