import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'home.dart';
import 'app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'api_list_model.dart';
import 'seat.dart';

class Search extends StatefulWidget {
  final arrTime;
  final seatNum;
  final price;
  final start;
  final arr;
  final selected;
  final selected2;
  final rotId;

  Search({
    Key? key,
    required this.selected,
    required this.selected2,
    required this.start,
    required this.arr,
    required this.arrTime,
    required this.seatNum,
    required this.rotId,
    required this.price,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DateTime dateTime = DateTime.now();
  static late int current_index = 0;
  late List<ApiListModel> datas = [];

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  Future<List<ApiListModel>> getData() async {
    CollectionReference<Map<String, dynamic>> collectionReference;

    collectionReference =
        FirebaseFirestore.instance.collection('${widget.rotId}');
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();

    for (var doc in querySnapshot.docs) {
      ApiListModel listModel = ApiListModel.fromQuerySnapShot(doc);
      datas.add(listModel);
    }
    current_index = datas.length;
    print("get_Post${datas.length}");
    print(datas[0].date.toString());
    return datas;
  }

  // _loadContents() async {
  //   await Future.delayed(Duration(seconds: 1));
  // }

  _makeDataList(var datas) {
    print("로트아이디내놔${widget.rotId}");
    print("price${widget.price}");

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext _context, int index) {
        // return GestureDetector(
        //     onTap: () {},
        //     child: Container(
        //       child:
        return Row(children: [
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                margin: EdgeInsets.all(3),
                padding: EdgeInsets.all(3),
                child: Text(
                  datas[index].startTer.toString(),
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SizedBox(width: 6),
              Container(
                //color: Colors.amber,
                margin: EdgeInsets.all(3),
                padding: EdgeInsets.all(3),
                child: Text(
                  datas[index].arrTer.toString(),
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Text(
                  "${datas[index].date.toString().substring(4, 6)}월${datas[index].date.toString().substring(6)}일",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Text(
                  "${datas[index].time.toString().substring(0, 2)}시${datas[index].time.toString().substring(2)}분",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Text(
                  "${datas[index].seatNum.toString()}석",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Container(
                          width: 30,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "신청하시겠습니까?",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 138, 43, 43)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MyApp1(),
                                            ));
                                      },
                                      child: Text("확인")),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 138, 43, 43)),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("취소")),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 138, 43, 43),
                ),
                child: Text(
                  "${datas[index].price.toString()}원",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ]),
          )
        ]);
      },
      separatorBuilder: (BuildContext _context, int index) {
        return Container(height: 1, color: Colors.black.withOpacity(0.4));
      },
      itemCount: datas.length,
      //),
    );
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 138, 43, 43),
      title: Text("버스 예매"),
    );
  }

  @override
  Widget build(BuildContext context) {
    //getData();
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
                      widget.start,
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
                      widget.arr,
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
              height: 30,
              indent: 20.0,
              endIndent: 20.0,
              color: Colors.grey),
          Text(
            "${widget.selected} ${widget.selected2} 이후",
            style: TextStyle(fontSize: 18),
          ),
          Divider(
              thickness: 1,
              height: 20,
              indent: 20.0,
              endIndent: 20.0,
              color: Colors.grey),
          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "출발지 \t\t\t\t 도착지 \t\t\t\t 날짜  \t\t\t\t시간  \t\t\t\t 남은좌석  \t\t\t  가격",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                      thickness: 1,
                      height: 20,
                      indent: 20.0,
                      endIndent: 20.0,
                      color: Colors.grey),
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      //_loadContents(),
                      Container(child: _makeDataList(datas), height: 400),
                    ],
                  )),
                  ElevatedButton(
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
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
                              FirebaseFirestore.instance.collection('survey');
                          collRef.add({
                            'startTer': "${widget.start}",
                            'arrTer': "${widget.arr}",
                            'date':
                                "${dateTime.year.toString()}${dateTime.month.toString().padLeft(2, '0')}${dateTime.day.toString().padLeft(2, '0')}",
                            'time':
                                "${dateTime.hour.toString().padLeft(2, '0')}${dateTime.minute.toString().padLeft(2, '0')}",
                            'seatNum': '1',
                          });
                        });
                      }
                    },
                    child: Text("타고싶은 시간이 없다면?"),
                  ),
                ]),
          )
        ]));
  }
}
