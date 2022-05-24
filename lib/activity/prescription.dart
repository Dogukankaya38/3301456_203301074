import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/activity/grade/prescriptionWriteDoctor.dart';
import 'package:hospital_app/activity/prescription_detail.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../entity/PrescriptionDto.dart';
import '../const/base.dart';

class Prescription extends StatefulWidget {
  @override
  _Prescription createState() => _Prescription();
}

class _Prescription extends State<Prescription> {
  late Future prescriptionLists;
  bool isVisible = false;

  Future getAllPrescription() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    // Await the http get response, then decode the json-formatted response.
    setState(() {
      isVisible = sharedPreferences.getBool("isTrue")!;
    });
    var body =
        jsonEncode({'userName': sharedPreferences.getString("userName")});
    var response = await http.post(
        Uri.parse("${Base.baseURL}8088/rest/prescription/"),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          "content-type": "application/json"
        },
        body: body);
    var jsonData = jsonDecode(response.body);
    List<PrescriptionDto> lists = [];
    for (var obj in jsonData) {
      PrescriptionDto reportDto = PrescriptionDto(
          //prescription reçete numarasına göre arama yapılacak
          obj["id"],
          obj["prescription"],
          obj["prescriptionType"],
          obj["doctor"],
          obj["createdDate"]);
      lists.add(reportDto);
    }
    return lists;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      prescriptionLists = getAllPrescription();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 243, 227),
          appBar: AppBar(
            title: const Text(
              'REÇETELERİM',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: <Widget>[
              Visibility(
                visible: isVisible,
                child: Container(
                  margin: const EdgeInsets.only(right: 10, top: 2, bottom: 2),
                  child: RaisedButton(
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black38, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrescriptionWriteDoctor()));
                    },
                    color: const Color.fromARGB(255, 255, 243, 227),
                    child: const Text(
                      'Reçete Yaz',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "NotoSerif",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            backgroundColor: const Color.fromARGB(255, 255, 243, 227),
          ),
          body: FutureBuilder(
              future: prescriptionLists,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container();
                } else {
                  return Container(
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10.0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return listItem(
                          context,
                          snapshot.data[i].prescription,
                          snapshot.data[i].createdDate,
                          snapshot.data[i].prescriptionType,
                          snapshot.data[i].doctor,
                        );
                      },
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget listItem(BuildContext context, String prescription, String createdDate,
      String prescriptionType, String doctor) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Reçete No : $prescription',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'Reçete Türü : $prescriptionType',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      'Hekim : $doctor',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 42,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      createdDate,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10, top: 30),
                    child: RaisedButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      onPressed: () async {
                        var sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setString(
                            "prescription", prescription);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrescriptionDetail()));
                      },
                      color: const Color.fromARGB(255, 255, 243, 227),
                      child: const Text(
                        'Detay Görüntüle',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: "NotoSerif",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
