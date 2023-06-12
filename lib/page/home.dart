import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/signin.dart';
import 'search.dart';
import 'package:flutter_application_1/page/repository.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime date = DateTime.now();
  late String selected =
      "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 138, 43, 43),
      title: Text("버스 예매"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbarWidget(),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('고갱님', style: TextStyle(fontSize: 20)),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("날짜"),
                Text("${selected}"),
                ElevatedButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2023),
                      //마지막 선택가능 날짜(유동)
                      lastDate: DateTime(2024),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        date = selectedDate;
                        selected =
                            "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                      });
                    }
                  },
                  child: Icon(Icons.calendar_month),
                ),
              ],
            ),
            Divider(
                thickness: 1,
                height: 60,
                indent: 20.0,
                endIndent: 20.0,
                color: Colors.grey),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Search(
                              selected: selected.toString(),
                            )),
                  );
                },
                child: Text("조회하기"))
          ],
        ));
  }
}
