import 'package:flutter/material.dart';
import 'package:hospital_app/const/base.dart';
import 'package:hospital_app/entity/hospitalDto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../entity/MedicineDto.dart';

// ignore: use_key_in_widget_constructors
class PrescriptionWriteDoctor extends StatefulWidget {
  @override
  _PrescriptionWriteDoctorState createState() =>
      _PrescriptionWriteDoctorState();
}


class _PrescriptionWriteDoctorState extends State<PrescriptionWriteDoctor> {
  late  Future<List<String>> listsDepartment;
  late  Future listsHospital;
  late  Future<List<String>> listsUsers;
  late  Future<List<String>> listCountry;
  late Future<List<MedicineDto>> listMedicine;
  List<MedicineDto> medicineList = [];
  List<MedicineDto> selectedList = [];

  late  String dropDownValueDepartment="Klinik";
  late  String dropDownValueHospital="Hastane";
  late String dropDownValueUsers="Hastalar";
  late String dropDownValueCountry="Şehirler";
  late String dropDownValueMedicine="İlaçlar";

  late MedicineDto selectedMedicine;

  Future<List<String>> getAllDepartment() async {
    // Await the http get response, then decode the json-formatted response.
    var response = await http
        .post(Uri.parse("${Base.baseURL}8086/rest/department/"), headers: {
      'Accept': 'application/json; charset=UTF-8',
      "content-type": "application/json"
    });
    var jsonData = jsonDecode(response.body);
    List<String> list = [];

    for (var obj in jsonData) {
      list.add(obj["department"]);
    }
    return list;
  }

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

  Future<List<HospitalDto>> getAllHospital() async {
    var body = jsonEncode({'city': dropDownValueCountry});
    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(
        Uri.parse("${Base.baseURL}8086/rest/hospital/country"),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          "content-type": "application/json"
        },
        body: body);
    var jsonData = jsonDecode(response.body);
    List<HospitalDto> list = [];
    for (var obj in jsonData) {
      var hospitalDto = HospitalDto(obj["hospitalName"]);
      list.add(hospitalDto);
    }
    return list;
  }

  Future<List<String>> getAllCountry() async {
    // Await the http get response, then decode the json-formatted response.
    var response = await http
        .post(Uri.parse("${Base.baseURL}8086/rest/country/"), headers: {
      'Accept': 'application/json; charset=UTF-8',
      "content-type": "application/json"
    });
    var jsonData = jsonDecode(response.body);
    List<String> list = [];
    for (var obj in jsonData) {
      list.add(obj["name"]);
    }
    return list;
  }

  Future<List<MedicineDto>> getAllMedicine() async {
    // Await the http get response, then decode the json-formatted response.
    var response = await http
        .post(Uri.parse("${Base.baseURL}8086/rest/medicine/"), headers: {
      'Accept': 'application/json; charset=UTF-8',
      "content-type": "application/json"
    });
    var jsonData = jsonDecode(response.body);
    medicineList = [];
    for (var obj in jsonData) {
      MedicineDto dto = MedicineDto(obj["barcode"], obj["medicineName"],
          obj["useType"], obj["period"], obj["dose"]);
      medicineList.add(dto);
    }
    return medicineList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      listsHospital = getAllHospital();
      listsDepartment = getAllDepartment();
      listsUsers = getAllUser();
      listCountry = getAllCountry();
      listMedicine = getAllMedicine();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 243, 227),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 243, 227),
          title: const Text(
            'REÇETE OLUŞTUR',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 15, right: 10, top: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FutureBuilder<List<HospitalDto>>(
                        future: getAllHospital(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? DropdownButton<String>(
                                  hint: Text(
                                      dropDownValueHospital),
                                  items: snapshot.data!
                                      .map<DropdownMenuItem<String>>((item) {
                                    return DropdownMenuItem<String>(
                                      value: item.hospitalName,
                                      child: Text(item.hospitalName,
                                          style: const TextStyle(fontSize: 15),
                                          textAlign: TextAlign.left),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      dropDownValueHospital = value!;
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
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 15, top: 10),
                      child: FutureBuilder<List<String>>(
                          future: listsDepartment,
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? DropdownButton<String>(
                                    hint: Text(
                                        dropDownValueDepartment),
                                    items: snapshot.data!
                                        .map<DropdownMenuItem<String>>((item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item,
                                            style: const TextStyle(fontSize: 15),
                                            textAlign: TextAlign.left),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropDownValueDepartment = value!;
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
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 15, top: 10),
                      child: FutureBuilder<List<String>>(
                          future: listCountry,
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? DropdownButton<String>(
                                    hint: Text(dropDownValueCountry),
                                    items: snapshot.data!
                                        .map<DropdownMenuItem<String>>((item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item,
                                            style: const TextStyle(fontSize: 15),
                                            textAlign: TextAlign.left),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropDownValueCountry = value!;
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
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 15, top: 10),
                  child: FutureBuilder<List<String>>(
                      future: listsUsers,
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? DropdownButton<String>(
                                hint:
                                    Text(dropDownValueUsers),
                                items: snapshot.data!
                                    .map<DropdownMenuItem<String>>((item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item,
                                        style: const TextStyle(fontSize: 15),
                                        textAlign: TextAlign.left),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 15, top: 10),
                    child: FutureBuilder<List<MedicineDto>>(
                        future: listMedicine,
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? DropdownButton<String>(
                                  hint:
                                      Text(dropDownValueMedicine),
                                  items: snapshot.data!
                                      .map<DropdownMenuItem<String>>((item) {
                                    return DropdownMenuItem<String>(
                                      value: item.medicineName,
                                      child: Text(item.medicineName,
                                          style: const TextStyle(fontSize: 15),
                                          textAlign: TextAlign.left),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      dropDownValueMedicine = value!;
                                      for (var obj in medicineList) {
                                        if (obj.medicineName == value) {
                                          selectedMedicine = obj;
                                          break;
                                        }
                                      }
                                      print("selected :" +
                                          selectedMedicine.medicineName);
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
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 25, top: 10),
                  child: RaisedButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    onPressed: () {
                      setState(() {
                        if (!selectedList.contains(selectedMedicine)) {
                          selectedList.add(selectedMedicine);
                        }
                      });
                    },
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Text(
                      'İlaç Ekle',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "NotoSerif",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    itemCount: selectedList.length,
                    itemBuilder: (context, i) {
                      return listItem(context, selectedList[i].medicineName, i);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 25, top: 10),
                  child: RaisedButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    onPressed: create,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Text(
                      'Reçeteyi Oluştur',
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
      ),
    );
  }

  void create() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    // Await the http get response, then decode the json-formatted response.
    List encondeToJson(List<MedicineDto> list) {
      List jsonList = [];
      list.map((item) => jsonList.add(item.toJson())).toList();
      return jsonList;
    }

    var body = jsonEncode({
      'userName': dropDownValueUsers,
      'prescriptionType': "normal",
      'doctor': sharedPreferences.getString("userName"),
      'createdDate':
          '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
      'hospitalName': dropDownValueHospital,
      'department': dropDownValueDepartment,
      'medicineList': encondeToJson(selectedList)
    });

    var response = await http.post(
        Uri.parse("${Base.baseURL}8088/rest/prescription/save"),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          "content-type": "application/json"
        },
        body: body);
    if(response.body=="created"){
      Base().message("Reçete Oluşturuldu..");
    }else{
      Base().message("Beklenmedik Bir hata oops..");
    }
  }

  Widget listItem(BuildContext context, String medicineName, int index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            selectedList.removeAt(index);
          });
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              medicineName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "NotoSerif",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

