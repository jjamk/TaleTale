import 'package:flutter/material.dart';
import 'home.dart';
import 'repository.dart';
import 'app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:flutter_localization/flutter_localization.dart';

class Search extends StatefulWidget {
  Search({Key? key, required this.selected}) : super(key: key);

  final selected;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DateTime dateTime = DateTime.now();

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 138, 43, 43),
      title: Text("버스 예매"),
    );
  }

  Widget _listWidget() {
    return FutureBuilder(
        future: _future(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData == false) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15),
                ));
          } else {
            return Text(snapshot.data.toString());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "출발지",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  child: Text(
                    "동서울",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
                ),
              ],
            ),
            width: 180,
            height: 200,
            margin: const EdgeInsets.fromLTRB(8, 25, 8, 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(38.5),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 33,
                    color: Color(0xFFD3D3D3).withOpacity(.84),
                  ),
                ]),
          ),
          Text("<->"),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "도착지",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  child: Text(
                    "대전복합",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  margin: EdgeInsets.fromLTRB(20, 50, 20, 50),
                ),
              ],
            ),
            width: 180,
            height: 200,
            margin: const EdgeInsets.fromLTRB(8, 25, 8, 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(38.5),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 33,
                    color: Color(0xFFD3D3D3).withOpacity(.84),
                  ),
                ]),
          ),
        ]),
        Divider(
            thickness: 1,
            height: 60,
            indent: 20.0,
            endIndent: 20.0,
            color: Colors.grey),
        Text(
          "${widget.selected}",
        ),
        Divider(
            thickness: 1,
            height: 60,
            indent: 20.0,
            endIndent: 20.0,
            color: Colors.grey),
        _listWidget(),
        ElevatedButton(
          //child: const Text("타고 싶은 시간이 없다면?"),
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 138, 43, 43)),
          onPressed: () async {
            final selectedDate = await showOmniDateTimePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.utc(2023, 7, 31),
              is24HourMode: false,
              isShowSeconds: false,
              minutesInterval: 15,
              secondsInterval: 1,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              constraints: const BoxConstraints(
                maxWidth: 350,
                maxHeight: 650,
              ),
              transitionBuilder: (context, anim1, anim2, child) {
                return FadeTransition(
                  opacity: anim1.drive(
                    Tween(
                      begin: 0,
                      end: 1,
                    ),
                  ),
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 200),
              barrierDismissible: true,
              context: context,
            );

            if (selectedDate != null) {
              setState(() {
                dateTime = selectedDate;
                CollectionReference collRef =
                    FirebaseFirestore.instance.collection('dday');
                collRef.add({
                  'day': dateTime.toString(),
                });
              });
            }
          },
          child: Text(
              "${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}  ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}"),
        ),
      ]),
    );

    // // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //           content: Text("타고싶은 시간 입력"),
    //           insetPadding: const EdgeInsets.all(30),
    //           actions: [
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: Text("같이 탈래 신청하기")),
    //             TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: Text("취소")),
    //           ]);
    //     });
  }

  Future _future() async {
    await Future.delayed(Duration(seconds: 2));
    return "요기는 게시글이 뜰거에요";
  }
}
