import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hospital_app/activity/home.dart';
import 'package:hospital_app/activity/register.dart';
import 'package:hospital_app/const/base.dart';
import 'package:hospital_app/widgets/CustomTextFieldWidget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/CustomRegisterRotateWidget.dart';

TextEditingController controllerUserName = TextEditingController();
TextEditingController controllerPassword = TextEditingController();

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginHome();
}

class LoginHome extends State<LoginPage> {
  Future<void> autoFill() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      controllerUserName.text = sharedPreferences.getString("userName")!;
      controllerPassword.text = sharedPreferences.getString("password")!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    autoFill();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          resizeToAvoidBottomInset: true,
          body: Card(
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                Expanded(
                  flex: 65,
                  child: Container(
                    margin: const EdgeInsets.only(top: 70),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset('assets/images/animasyon.gif'),
                    ),
                  ),
                ),
                Expanded(
                  flex: 48,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CustomTextFieldRegisterWidget(
                            controllerUserName,
                            "Kullan??c?? ad??",
                            false,
                            const Color.fromARGB(255, 89, 89, 81),
                          ),
                          CustomTextFieldRegisterWidget(
                            controllerPassword,
                            "??ifre",
                            true,
                            const Color.fromARGB(255, 89, 89, 81),
                          ),
                          CustomLogin(),
                          CustomRegisterRotate()
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
} // login sayfas??

class CustomLogin extends StatelessWidget {
  void getLogin(BuildContext context) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    // Await the http get response, then decode the json-formatted response.
    var body = jsonEncode({
      'userName': controllerUserName.text,
      'password': controllerPassword.text
    });

    var response = await http.post(
        Uri.parse("${Base.baseURL}8080/rest/authentication/login"),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          "content-type": "application/json"
        },
        body: body);
    if (response.body != "false") {
      sharedPreferences.setString("userName", controllerUserName.text);
      sharedPreferences.setString("password", controllerPassword.text);
      if (response.body != "user") {
        sharedPreferences.setBool("isTrue", true);
      } else {
        sharedPreferences.setBool("isTrue", false);
      }
      Base().message("Giri?? Ba??ar??l??");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
        (route) => false,
      );
    } else {
      print("login could not be verified"); // giri?? do??rulanmad??
      Base().message("Kullan??c?? Ad?? ve ??ifrenizi Kontrol ediniz...");
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
        color: const Color.fromARGB(255, 89, 89, 81),
        child: const Text(
          'Giri?? Yap',
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
} // uygulamaya giri?? yapar
