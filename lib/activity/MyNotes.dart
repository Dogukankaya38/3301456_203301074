import 'dart:math';

import 'package:hospital_app/entity/MessageDto.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/const/base.dart';

import '../db/DatabaseHandler.dart';

class MyNotes extends StatefulWidget {
  const MyNotes({Key? key}) : super(key: key);

  @override
  _MyNotesState createState() => _MyNotesState();
}

TextEditingController textEditingController = TextEditingController();

class _MyNotesState extends State<MyNotes> {


  late DatabaseHandler handler;
  var key = Base();
  late Future<List<MessageDto>> list;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB();
    list = handler.retrieveUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'NOTLARIM',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: <Widget>[
              Container(
                color: Colors.blue,
                margin: const EdgeInsets.only(right: 10, top: 2, bottom: 2),
                child: RaisedButton(
                  color: Colors.blue,
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black38, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  onPressed: () {
                    showCustomDialog(context);
                  },
                  child: const Text(
                    'Not Ekle',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: "NotoSerif",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<List<MessageDto>>(
              future: list,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${snapshot.data[index].name}"),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(15)),
                        );
                      });
                } else if (snapshot.hasError) {
                  return const Text("Error");
                }
                return const Text("Loading...");
              },
            ),
          ),
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Center(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Not Ekle',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(2.5),
                    child: TextField(
                      controller: textEditingController,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(right: 25, top: 10),
                    child: RaisedButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      onPressed: () {
                        handler.insertUser(MessageDto(
                            id: Random().nextInt(100000000),
                            name: textEditingController.text));
                        setState(() {
                          list = handler.retrieveUsers();
                        });
                      },
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: const Text(
                        'Kaydet',
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
          );
        });
      },
    );
  }

}
