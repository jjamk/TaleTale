import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/model.dart';

//지정된 터미널의 정보를 담은 api 엔드포인트와 접속에 필요한 헤더
Future<lin_list_ApiResponse> lin_list_fetchData(String selDiv, String terCod) async {
  const url = 'https://apigw.tmoney.co.kr:5556/gateway/xzzLinListGet/v1/lin_list';
  final headers = {
    'Cache-Control': 'no-cache',
    'Accept': '*/*',
    'x-Gateway-APIKey': '17cf9fbd-9937-458a-bb6e-931bfd49d8cf',
  };
  //url 엔드포인트에 매개변수 입력
  final uri = Uri.parse(url+"/"+selDiv+"/"+terCod);
  // api에 get 방식으로 데이터 받아오기
  final response = await http.get(uri, headers: headers);
  // api 상태 코드와 입력된 엔드포인트 확인용 코드
  print('상태 코드: ${response.statusCode}');
  print('엔드포인트: $uri');
  // 상태 코드가 정상인 200일때와 새로운 정보가 추가된 201일때 데이터를 받아오는 코드 그 의외 상태코드는 예외처리
  if (response.statusCode == 200 || response.statusCode == 201) {
    final data = json.decode(response.body);
    return lin_list_ApiResponse.fromJson(data);
  } else {
    throw Exception('Failed to fetch data');
  }
}
// void main() async {
//   final selDiv = 's'; // selDiv 값 입력
//   final terCod = '1045001'; // terCod 값 입력
//  try {
//     final lin_list_result = await lin_list_fetchData(selDiv, terCod);
//     final lin_list_apiResponse = lin_list_result as lin_list_ApiResponse;   
//     print('코드: ${lin_list_apiResponse.code}');
//     print('메시지: ${lin_list_apiResponse.message}');  
//     print('터미널 리스트:');
//     for (final terminal in lin_list_apiResponse.terList) {
//       print('터미널명: ${terminal.terNam}');
//       print('터미널 코드: ${terminal.terCod}');
//       // 필요한 다른 속성들도 출력 가능
//     }
//   } catch (e) {
//     print('오류 발생: $e');
//   }
// }

//전체 터미널의 정보를 담은 api 엔드포인트와 접속에 필요한 헤더
Future<load_info_ApiResponse> load_info_fetchData(String inDate) async {
  const url = 'https://apigw.tmoney.co.kr:5556/gateway/xzzLoadInfoGet/v1/load_info';
  final headers = {
    'Cache-Control': 'no-cache',
    'Accept': '*/*',
    'x-Gateway-APIKey': '17cf9fbd-9937-458a-bb6e-931bfd49d8cf',
  };
  //url 엔드포인트에 매개변수 입력
  final uri = Uri.parse(url+"/"+inDate);
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
Future<ibt_list_ApiResponse> ibt_list_fetchData(String timDte, String timTimI, String terFrI, String terToI) async {
  const url = 'https://apigw.tmoney.co.kr:5556/gateway/xzzIbtListGet/v1/ibt_list';
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
  final uri = Uri.parse(url+"/"+timDte+"/"+timTimI+"/"+terFrI+"/"+terToI+"/"+busGraI+"/"+calFlg);
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

// 완벽히 지정된 노선에 대한 좌석 여부와 요금 데이터를 받아오는 api 엔드포인트와 접속에 필요한 헤더
Future<ibt_info_ApiResponse> ibt_info_fetchData(String terSfr, String terSto, String rotId, String rotSqno, String alcnDt, String alcnSqno) async {
  const url = 'https://apigw.tmoney.co.kr:5556/gateway/xzzIbtInfoGet/v1/ibt_info';
  final headers = {
    'Cache-Control': 'no-cache',
    'Accept': '*/*',
    'x-Gateway-APIKey': '17cf9fbd-9937-458a-bb6e-931bfd49d8cf',
  };

  //url 엔드포인트에 매개변수 입력
  final uri = Uri.parse(url+"/"+terSfr+"/"+terSto+"/"+rotId+"/"+rotSqno+"/"+alcnDt+"/"+alcnSqno);
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

  try {
  //전체 터미널 정보를 호출해 입력된 지역의 터미널 코드를 얻고 코드를 이용해 노선을 보여주는 코드
  // final selDiv = 's'; // selDiv 값 입력
  // final inDate = '00000000000000'; // inDate 값 입력
  // final String startTer= '대전'; // 출발지역 입력
  // final String finishTer = '청주'; // 도착지역 입력
  //       final load_info_result = await load_info_fetchData(inDate);
  //   final load_info_apiResponse = load_info_result as load_info_ApiResponse;   
  //   print('코드: ${load_info_apiResponse.code}');
  //   print('메시지: ${load_info_apiResponse.message}');  
  //   print('터미널 리스트:');
  //   for (final terminal in load_info_apiResponse.response.terList) {
  //     if(terminal.terNam == startTer){
  //       final terCod = terminal.terCod;
  //       final selDiv = 's';
  //     print('터미널명: ${terminal.terNam}');
  //     print('터미널 코드: ${terminal.terCod}');

  //     final lin_list_result = await lin_list_fetchData(selDiv, terCod);
  //     final lin_list_apiResponse = lin_list_result as lin_list_ApiResponse;   
  //     print('코드: ${lin_list_apiResponse.code}');
  //     print('메시지: ${lin_list_apiResponse.message}');  
  //     print('터미널 리스트:');
  //   for (final terminal in lin_list_apiResponse.terList) {
  //     print('터미널명: ${terminal.terNam}');
  //     print('터미널 코드: ${terminal.terCod}');
  //     }
  //   }
  //   }

  // 완벽히 지정된 노선의 좌석과 좌석 예매 여부를 출력하는 코드
    final String terSfr = '2839701'; // 출발 터미널 코드
    final String terSto = '3455101'; // 도착 터미널 코드
    final String rotId = 'RT201605253073982'; // 노선 ID
    final String rotSqno = '1'; // 노선 순번
    final String alcnDt = '20230613'; // 배차 날짜
    final String alcnSqno = '1'; // 배차 순번
  
    final ibt_info_result = await ibt_info_fetchData(terSfr, terSto, rotId, rotSqno, alcnDt, alcnSqno);
    final ibt_info_apiResponse = ibt_info_result as ibt_info_ApiResponse; 
    print('코드: ${ibt_info_apiResponse.code}');
    print('메시지: ${ibt_info_apiResponse.message}');  
    print('좌석 여부');
  if (ibt_info_apiResponse.response != null && ibt_info_apiResponse.response!.seatList != null) {
  for (final terminal in ibt_info_apiResponse.response!.seatList!) {
    print('좌석번호: ${terminal.number}');
    print('예매여부: ${terminal.status}');
  }
} else {
  print('데이터가 없습니다.');
}

    // 출발지와 도착지가 정해진 노선의 배치된 배차들의 시간과 배차된 버스 종류를 출력하는 코드
    // final String timDte = '20230613'; // 배차날짜
    // final String timTimI = '1500'; // 원하는 출발 시각
    // final String terFrI = '2839701'; // 출발 터미널 코드번호
    // final String terToI = '3455101'; // 도착 터미널 코드번호
    // int int_timTimI = int.parse(timTimI);
    //    final ibt_list_result = await ibt_list_fetchData(timDte, timTimI, terFrI, terToI);
    // final ibt_list_apiResponse = ibt_list_result as ibt_list_ApiResponse;   
    // print('코드: ${ibt_list_apiResponse.code}');
    // print('메시지: ${ibt_list_apiResponse.message}');  
    // print('터미널 리스트:');
    // for (final terminal in ibt_list_apiResponse.response.lineList) {
    //   int int_terminal_timTimO = int.parse(terminal.timTimO); 
    //    if(int_terminal_timTimO > int_timTimI){
    //   print('출발시간: ${terminal.timTimO}');
    //   print('잔여좌석수: ${terminal.remCnt}');
    //   print('총좌석수: ${terminal.webCnt}');
    //   }
    // }
  } catch (e) {
    print('오류 발생: $e');
 }
}