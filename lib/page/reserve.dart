import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../signin.dart';

void main() {
  runApp(Reserve());
}

class Reserve extends StatefulWidget {
  @override
  _ReserveState createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
  String departure = '대전복합'; // db에 저장된 출발지 불러오기
  String destination = '청주'; // db에 저장된 도착지 불러오기
  int selectedSeatNumber = 1; // db에 저장된 좌석번호 불러오기
  String busGrade = '우등'; // 우등 고정
  String duration = '70'; //db에 저장된 소요시간 불러오기
  String date = '2023년 06월 30일'; //db에 저장된 날짜 불러오기
  String time = '11시 30분'; // db에 저장된 시간 불러오기
  String formattedDuration = '';
  String formattedDate = '';
  String formattedTime = '';

  @override
  void initState() {
    super.initState();
    formattedDate = insertHyphen_date(date);
    formattedTime = insertHyphen_time(time);
    formattedDuration = insertHyphen_duration(duration);
  }

  String insertHyphen_date(String text) {
    //String modifiedText =
    text.substring(0, 4) + text.substring(4, 6) + text.substring(6);
    //return modifiedText;
    return date;
  }

  String insertHyphen_time(String text) {
    //String modifiedText = text.substring(0, 2) + " : " + text.substring(2, 4);
    //return modifiedText;
    return time;
  }

  String insertHyphen_duration(String text) {
    final hour = int.parse(text) ~/ 60;
    final min = int.parse(text) % 60;
    String modifiedText = hour.toString() + ":" + min.toString();
    return modifiedText;
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 138, 43, 43),
      title: Text("예매 확인"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _appbarWidget(),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('태산 님', style: TextStyle(fontSize: 20)),
                accountEmail: Text(
                  '안전한 하루 되세요!',
                  style: TextStyle(fontSize: 12),
                ),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 138, 43, 43),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0))),
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Text("로그아웃"),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '전자승차권 스캔',
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40.0),
                  Image.asset(
                    'assets/images/QR.png', // 이미지 파일 경로
                    width: 100.0, // 이미지 가로 크기
                    height: 100.0, // 이미지 세로 크기
                  ),
                  SizedBox(height: 30),
                ],
              ),
              SizedBox(height: 30),
              Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.black,
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '출발지 : $departure',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10.0),
                  Image.asset(
                    'assets/images/arrow.png', // 이미지 파일 경로
                    width: 50.0, // 이미지 가로 크기
                    height: 50.0, // 이미지 세로 크기
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    '도착지 : $destination',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                ],
              ),
              SizedBox(height: 30),
              Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.black,
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '날짜 : $formattedDate',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    '출발 시간 : $formattedTime',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.black,
              ),
              SizedBox(height: 20.0),
              Text(
                '좌석 번호 : $selectedSeatNumber',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Text(
                '버스 등급 : $busGrade',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Text(
                '소요 시간 : $formattedDuration',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
