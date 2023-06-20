import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/model/api_model.dart';
import 'package:flutter_application_2/page/seat.dart';
import 'package:flutter_application_2/signin.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import '../notification.dart';
import 'search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'seat.dart';
import '../notification.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final firestore = FirebaseFirestore.instance;
  String startTer = '';
  String arrTer = '';
  String arrTime = '';
  String seatNum = '';
  String rotId = '';
  String price = '';
  DateTime date = DateTime.now();
  late String selected =
      "${date.year.toString()}년 ${date.month.toString().padLeft(2, '0')}월 ${date.day.toString().padLeft(2, '0')}일 ";
  late String selected2 =
      "${date.hour.toString().padLeft(2, '0')}시 ${date.minute.toString().padLeft(2, '0')}분";
  @override
  void initState() {
    FlutterLocalNotification.init(); // TODO: implement initState
    super.initState();
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 138, 43, 43),
      title: Text("버스 예매"),
    );
  }

  Future<load_info_ApiResponse> load_info_fetchData(String inDate) async {
    const url =
        'https://apigw.tmoney.co.kr:5556/gateway/xzzLoadInfoGet/v1/load_info';
    final headers = {
      'Cache-Control': 'no-cache',
      'Accept': '*/*',
      'x-Gateway-APIKey': '17cf9fbd-9937-458a-bb6e-931bfd49d8cf',
    };
    //url 엔드포인트에 매개변수 입력
    final uri = Uri.parse(url + "/" + inDate);
    // api에 get 방식으로 데이터 받아오기
    final response = await http.get(uri, headers: headers);
    // api 상태 코드와 입력된 엔드포인트 확인용 코드
    print('상태 코드: ${response.statusCode}');
    print('엔드포인트: $uri');
    // 상태 코드가 정상인 200일때와 새로운 정보가 추가된 201일때 데이터를 받아오는 코드 그 의외 상태코드는 예외처리
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      return load_info_ApiResponse.fromJson(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  // 지정된 노선에 대한 정보를 담은 api 엔드포인트와 접속에 필요한 헤더
  Future<ibt_list_ApiResponse> ibt_list_fetchData(
      String timDte, String timTimI, String terFrI, String terToI) async {
    const url =
        'https://apigw.tmoney.co.kr:5556/gateway/xzzIbtListGet/v1/ibt_list';
    final headers = {
      'Cache-Control': 'no-cache',
      'Accept': '*/*',
      'x-Gateway-APIKey': '17cf9fbd-9937-458a-bb6e-931bfd49d8cf',
    };
    //url 엔드포인트에 매개변수 입력

    // 버스를 등급별로 조회하는 기능에 대한 변수이지만 구분할 이유가 없으므로 전체를 보여주는 9로 고정함
    final String busGraI = '9';
    // 버스를 시간별로 조회하는 기능에 대한 변수이고 지정된 시간 이후의 배차만 보여주는 2로 고정함
    final String calFlg = '2';
    final uri = Uri.parse(url +
        "/" +
        timDte +
        "/" +
        timTimI +
        "/" +
        terFrI +
        "/" +
        terToI +
        "/" +
        busGraI +
        "/" +
        calFlg);
    // api에 get 방식으로 데이터 받아오기
    final response = await http.get(uri, headers: headers);
    // api 상태 코드와 입력된 엔드포인트 확인용 코드
    print('상태 코드: ${response.statusCode}');
    print('엔드포인트: $uri');
    // 상태 코드가 정상인 200일때와 새로운 정보가 추가된 201일때 데이터를 받아오는 코드 그 의외 상태코드는 예외처리
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      return ibt_list_ApiResponse.fromJson(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<ibt_info_ApiResponse> ibt_info_fetchData(String terSfr, String terSto,
      String rotId, String rotSqno, String alcnDt, String alcnSqno) async {
    const url =
        'https://apigw.tmoney.co.kr:5556/gateway/xzzIbtInfoGet/v1/ibt_info';
    final headers = {
      'Cache-Control': 'no-cache',
      'Accept': '*/*',
      'x-Gateway-APIKey': '17cf9fbd-9937-458a-bb6e-931bfd49d8cf',
    };

    //url 엔드포인트에 매개변수 입력
    final uri = Uri.parse(url +
        "/" +
        terSfr +
        "/" +
        terSto +
        "/" +
        rotId +
        "/" +
        rotSqno +
        "/" +
        alcnDt +
        "/" +
        alcnSqno);
    // api에 get 방식으로 데이터 받아오기
    final response = await http.get(uri, headers: headers);
    // api 상태 코드와 입력된 엔드포인트 확인용 코드
    print('상태 코드: ${response.statusCode}');
    print('엔드포인트: $uri');
    // 상태 코드가 정상인 200일때와 새로운 정보가 추가된 201일때 데이터를 받아오는 코드 그 의외 상태코드는 예외처리
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      return ibt_info_ApiResponse.fromJson(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  void main() async {
    String terCod1 = '';
    String terCod2 = '';
    String rotId = '';
    String rotSqno = ''; // 노선 순번// 배차 날짜
    String alcnSqno = '';
    String price = ''; // 배차 순번

    try {
      final inDate = '00000000000000';
      //출발지와 도착지가 정해진 노선의 배치된 배차들의 시간과 배차된 버스 종류를 출력하는 코드
      final String timDte =
          "${date.year.toString()}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}"; // 배차날짜
      final String timTimI =
          "${date.hour.toString().padLeft(2, '0')}${date.minute.toString().padLeft(2, '0')}"; // 원하는 출발 시각
      int int_timTimI = int.parse(timTimI);
      final load_info_result = await load_info_fetchData(inDate);
      final load_info_apiResponse = load_info_result as load_info_ApiResponse;
      for (final terminal in load_info_apiResponse.response.terList) {
        if (terminal.terNam == startTer) {
          terCod1 = terminal.terCod.toString();
          print('터미널명: ${terminal.terNam}');
          print('터미널 코드: ${terCod1}');
        } else if (terminal.terNam == arrTer) {
          terCod2 = terminal.terCod.toString();
          print('터미널명: ${terminal.terNam}');
          print('터미널 코드: ${terCod2}');
        }
      }

      final ibt_list_result =
          await ibt_list_fetchData(timDte, timTimI, terCod1, terCod2);
      final ibt_list_apiResponse = ibt_list_result as ibt_list_ApiResponse;

      for (final terminal in ibt_list_apiResponse.response.lineList) {
        int int_terminal_timTimO = int.parse(terminal.timTimO);

        if (int_terminal_timTimO > int_timTimI) {
          arrTime = terminal.timTimO;
          seatNum = terminal.remCnt;
          rotId = terminal.rotId;
          rotSqno = terminal.rotSqno;
          alcnSqno = terminal.alcnSqno;

          final ibt_info_result = await ibt_info_fetchData(
              terCod1, terCod2, rotId, rotSqno, timDte, alcnSqno);
          final ibt_info_apiResponse = ibt_info_result as ibt_info_ApiResponse;

          final t = ibt_info_apiResponse.response.tckFee1.toString();
          price = t;
          print('출발시간: ${terminal.timTimO}');
          print('잔여좌석수: ${terminal.remCnt}');
          print('총좌석수: ${terminal.webCnt}');
          print('rotid: ${rotId}');
          setState(() {
            CollectionReference collRef =
                FirebaseFirestore.instance.collection(terminal.rotId);

            collRef.add({
              'startTer': startTer,
              'arrTer': arrTer,
              'date': timDte,
              'time': arrTime,
              'seatNum': seatNum,
              'rotSqno': rotSqno,
              'alcnSqno': alcnSqno,
              'price': t,
              'rotId': rotId,
            });
          });
        }
      }
    } catch (e) {
      print('error${e}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1),
        FlutterLocalNotification.requestNotificationPermission());
    //main();
    return Scaffold(
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
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            startTer = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: '출발지를 입력',
                        ),
                      ),
                      // child: Text(
                      //   "동서울",
                      //   style: TextStyle(
                      //     fontSize: 30,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
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
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            arrTer = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: '도착지를 입력',
                        ),
                      ),
                      // child: Text(
                      //   "대전복합",
                      //   style: TextStyle(
                      //     fontSize: 30,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
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
                Text("날짜 |  "),
                Text("${selected}"),
                Text(" ${selected2} 이후  "),
                ElevatedButton(
                    child: Icon(Icons.calendar_month),
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
                          date = selectedDate;
                          selected =
                              "${date.year.toString()}년 ${date.month.toString().padLeft(2, '0')}월 ${date.day.toString().padLeft(2, '0')}일 ";
                          selected2 =
                              "${date.hour.toString().padLeft(2, '0')}시 ${date.minute.toString().padLeft(2, '0')}분";
                        });
                      }
                    }),
              ],
            ),
            Divider(
                thickness: 1,
                height: 60,
                indent: 20.0,
                endIndent: 20.0,
                color: Colors.grey),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 138, 43, 43)),
                onPressed: () {
                  main();
                  //FlutterLocalNotification.showNotification();
                  if (startTer != '' && arrTer != '') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Search(
                                  selected: selected.toString(),
                                  selected2: selected2.toString(),
                                  start: startTer.toString(),
                                  arr: arrTer.toString(),
                                  arrTime: arrTime.toString(),
                                  seatNum: seatNum.toString(),
                                  rotId: rotId.toString(),
                                  price: price.toString(),
                                )));
                  } else {}
                },
                child: Text("조회하기"))
          ],
        ));
  }
}
