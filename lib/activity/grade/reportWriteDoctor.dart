import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hospital_app/const/base.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController controllerExplanation = TextEditingController();
TextEditingController controllerTitle = TextEditingController();

// ignore: use_key_in_widget_constructors
class ReportWriteDoctor extends StatefulWidget {
  @override
  _ReportWriteDoctorState createState() => _ReportWriteDoctorState();
}

class _ReportWriteDoctorState extends State<ReportWriteDoctor> {
  late Future<List<String>> listUsers;
  late String dropDownValueUsers="";

  Future<List<String>> getAllUser() async {
    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(
        Uri.parse("${Base.baseURL}8080/rest/authentication/all"),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          "content-type": "application/json"
        });
    var jsonData = jsonDecode(response.body);
    List<String> list = [];
    for (var obj in jsonData) {
      list.add(obj["userName"]);
    }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      listUsers = getAllUser();
    });
  }
  void create() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    // Await the http get response, then decode the json-formatted response.
    if(dropDownValueUsers=="hastalar"){

      return;
    }

    var body = jsonEncode({
      'userName': dropDownValueUsers,
      'title': controllerTitle.text,
      'explanation': controllerExplanation.text.trim(),
      'createdDate':
      '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
    });

    var response = await http.post(
        Uri.parse("${Base.baseURL}8087/rest/report/save"),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          "content-type": "application/json"
        },
        body: body);
    if(response.body=="created"){
      Base().message("Rapor Oluşturuldu..");
    }else{
      Base().message("Beklenmedik Bir hata oops..");
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 243, 227),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 243, 227),
          title: const Text(
            'RAPOR OLUŞTUR',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10),
                color: const Color.fromARGB(255, 255, 243, 227),
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(
                      width: 1, color: Colors.black38),),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: FutureBuilder<List<String>>(
                        future: listUsers,
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? DropdownButton<String>(
                                  hint: Text(dropDownValueUsers),
                                  items: snapshot.data!
                                      .map<DropdownMenuItem<String>>((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Container(
                                        child: Text(item,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                            textAlign: TextAlign.left),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      dropDownValueUsers = value!;
                                      print(value);
                                    });
                                  },
                                )
                              : Container(
                                  child: const Center(
                                    child: Text('Loading...'),
                                  ),
                                );
                        }),
                  ),
                ),
              ),
              CustomTextFieldTitle(),
              CustomTextFieldExplanation(),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 25, top: 10),
                child: RaisedButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: create,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: const Text(
                    'Raporu Oluştur',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "NotoSerif",
                      fontWeight: FontWeight.w700,
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

// ignore: use_key_in_widget_constructors
class CustomTextFieldExplanation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 243, 227),
      margin: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 17,
      ),
      child: TextField(
        textAlign: TextAlign.start,
        maxLines: 7,
        minLines: 4,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        controller: controllerExplanation,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: "NotoSerif",
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
            labelText: "Rapor Açıklaması",
            labelStyle: const TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black38, width: 1.5),
              borderRadius: BorderRadius.circular(25.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                  width: 1, style: BorderStyle.none, color: Colors.black38),
            ),
            filled: true,
            hintStyle: const TextStyle(color: Colors.black),
            contentPadding: const EdgeInsets.all(16),
            hintText: "Açıklama",
            fillColor: Colors.white),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class CustomTextFieldTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 243, 227),
      margin: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 17,
      ),
      child: TextField(
        textAlign: TextAlign.start,
        maxLines: 3,
        minLines: 2,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        controller: controllerTitle,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: "NotoSerif",
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
            labelText: "Başlık",
            labelStyle: const TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black38, width: 1.5),
              borderRadius: BorderRadius.circular(25.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                  width: 1, style: BorderStyle.none, color: Colors.black38),
            ),
            filled: true,
            hintStyle: const TextStyle(color: Colors.black),
            contentPadding: const EdgeInsets.all(16),
            hintText: "Başlık",
            fillColor: Colors.white),
      ),
    );
  }
}
