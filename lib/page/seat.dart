import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/signin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/api_model.dart';

// 완벽히 지정된 노선에 대한 좌석 여부와 요금 데이터를 받아오는 api 엔드포인트와 접속에 필요한 헤더
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
  // print('상태 코드: ${response.statusCode}');
  // print('엔드포인트: $uri');
  // 상태 코드가 정상인 200일때와 새로운 정보가 추가된 201일때 데이터를 받아오는 코드 그 의외 상태코드는 예외처리
  if (response.statusCode == 200 || response.statusCode == 201) {
    final data = json.decode(response.body);
    return ibt_info_ApiResponse.fromJson(data);
  } else {
    throw Exception('Failed to fetch data');
  }
}

class CustomButton extends StatelessWidget {
  final int number;
  final double buttonSize;
  final bool isEnabled;

  const CustomButton({
    required this.number,
    required this.buttonSize,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonSize,
      height: buttonSize,
      child: InkWell(
        onTap: isEnabled
            ? () {
                _showOptionsDialog(context, number);
              }
            : null, // 버튼이 비활성화되면 onTap을 null로 설정하여 비활성화 상태로 만듭니다.
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: isEnabled ? 1.0 : 0.5, // 버튼이 비활성화되면 투명도를 조정합니다.
              child: Image.asset(
                'assets/images/버스의자.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              '$number', // 숫자 출력
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isEnabled
                    ? Colors.black
                    : Colors.white, // 버튼이 활성화되면 검은색으로 변경
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context, int number) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('좌석 선택'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('어른'),
                onTap: () {
                  print('선택된 좌석: $number, 선택: 어른');
                  Navigator.of(dialogContext).pop();
                },
              ),
              ListTile(
                title: Text('청소년'),
                onTap: () {
                  print('선택된 좌석: $number, 선택: 청소년');
                  Navigator.of(dialogContext).pop();
                },
              ),
              ListTile(
                title: Text('아동'),
                onTap: () {
                  print('선택된 좌석: $number, 선택: 아동');
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> main() async {
  // runApp(MyApp());
  runApp(MyApp1());
}
// 우등버스 위젯
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Button Demo',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Button Demo'),
//         ),
//         body: FutureBuilder<List<String>>(
//           future: method1(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               final list1 = snapshot.data!;
//               return GridView.count(
//                 crossAxisCount: 4,
//                 childAspectRatio: 1.0,
//                 children: List.generate(36, (index) {
//                   if ((index + 1) % 4 == 3 && index < 31) {
//                     return SizedBox.shrink();
//                   } else {
//                     final isEnabled = list1[index - ((index+1) ~/ 4)] == "Y";
//                     return Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: CustomButton(
//                         number: index + 1 - (index+1) ~/ 4,
//                         buttonSize: 100,
//                         isEnabled: isEnabled,
//                       ),
//                     );
//                   }
//                 }),
//               );
//             } else if (snapshot.hasError) {
//               return Text("Error: ${snapshot.error}");
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Future<List<String>> method1() async {
//     final String terSfr = '2839701'; // 출발 터미널 코드
//     final String terSto = '3455101'; // 도착 터미널 코드
//     final String rotId = 'RT201605253073982'; // 노선 ID
//     final String rotSqno = '1'; // 노선 순번
//     final String alcnDt = '20230613'; // 배차 날짜
//     final String alcnSqno = '1'; // 배차 순번

//     final ibt_info_result = await ibt_info_fetchData(
//         terSfr, terSto, rotId, rotSqno, alcnDt, alcnSqno);
//     final ibt_info_apiResponse = ibt_info_result as ibt_info_ApiResponse;

//     List<String> statusList = [];
//     for (final terminal in ibt_info_apiResponse.response!.seatList!) {
//       print(terminal.number);
//       print(terminal.status);
//       statusList.add(terminal.status);
//     }

//     return statusList;
//   }

class MyApp1 extends StatelessWidget {
  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 138, 43, 43),
      title: Text("좌석 조회"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Button Demo',
        home: Scaffold(
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
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (_) => false);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Text("로그아웃"),
                ),
              ],
            ),
          ),
          appBar: _appbarWidget(),
          body: FutureBuilder<List<String>>(
            future: method1(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final list1 = snapshot.data!;
                return GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                  children: List.generate(36, (index) {
                    if ((index + 1) % 4 == 3 && index < 31) {
                      return SizedBox.shrink();
                    } else {
                      final isEnabled =
                          list1[index - ((index + 1) ~/ 4)] == "Y";
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CustomButton(
                          number: index + 1 - (index + 1) ~/ 4,
                          buttonSize: 100,
                          isEnabled: isEnabled,
                        ),
                      );
                    }
                  }),
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ));
  }

  Future<List<String>> method1() async {
    final String terSfr = '2839701'; // 출발 터미널 코드
    final String terSto = '3455101'; // 도착 터미널 코드
    final String rotId = 'RT201605253073982'; // 노선 ID
    final String rotSqno = '1'; // 노선 순번
    final String alcnDt = '20230613'; // 배차 날짜
    final String alcnSqno = '1'; // 배차 순번

    final ibt_info_result = await ibt_info_fetchData(
        terSfr, terSto, rotId, rotSqno, alcnDt, alcnSqno);
    final ibt_info_apiResponse = ibt_info_result as ibt_info_ApiResponse;

    List<String> statusList = [];
    for (final terminal in ibt_info_apiResponse.response!.seatList!) {
      print(terminal.number);
      print(terminal.status);
      statusList.add(terminal.status);
    }

    return statusList;
  }
}
