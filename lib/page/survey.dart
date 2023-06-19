import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/notification.dart';
import '../signin.dart';
import '../page/listmodel.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(Survey());
// }

class Survey extends StatefulWidget {
  //static late String currentLocation;
  const Survey({super.key});

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  static late int current_index = 0;
  static late List<ListModel> datas = [];
  final firestore = FirebaseFirestore.instance;

  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }
  // getData() {
  //   String date = "";
  //   firestore.collection('dday').get().then((value) {
  //     setState(() {
  //       then = value.docs[0].data();
  //     });
  //     print("data: ${then['date']}");
  //   });
  // }

  Future<List<ListModel>> getData() async {
    CollectionReference<Map<String, dynamic>> collectionReference;

    collectionReference = FirebaseFirestore.instance.collection("survey");
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    for (var doc in querySnapshot.docs) {
      ListModel listModel = ListModel.fromQuerySnapShot(doc);
      datas.add(listModel);
    }
    current_index = datas.length;
    print("get_Post${datas.length}");
    print(datas[0].date.toString());
    return datas;
  }

  _makeDataList(var datas) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (BuildContext _context, int index) {
          return GestureDetector(
              onTap: () {},
              child: Container(
                child: SingleChildScrollView(
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  datas[index].startTer.toString(),
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                //color: Colors.amber,
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
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
                                  "${datas[index].seatNum.toString()}/41",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "신청하시겠습니까?",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          138,
                                                                          43,
                                                                          43)),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("확인")),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          138,
                                                                          43,
                                                                          43)),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
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
                                child: Text("나도\n탈래"),
                              ),
                            ]),
                      ),
                    )
                  ]),
                ),
              ));
        },
        separatorBuilder: (BuildContext _context, int index) {
          return Container(height: 1, color: Colors.black.withOpacity(0.4));
        },
        itemCount: datas.length);
  }

  _loadContents() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Widget _bodyWidget() {
    return FutureBuilder(
      future: _loadContents(),
      builder: (BuildContext context, dynamic snapshot) {
        print("current_idnex${current_index}");
//로딩 처리
        // if (current_index == 0) {
        //   getData();
        //   print(current_index);
        // }

        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }
        //에러 처리
        if (snapshot.hasError) {
          return Center(child: Text("데이터 오류"));
        }
        if (datas.length == 0) return const Center(child: Text("게시된 글이 없습니다."));
        //새 글이 올라왔을 때
        if (datas.length != current_index) {
          getData();
          print(datas.length);
          print("new");
          //print(current_index);
          return _makeDataList(snapshot.data);
        }
        //새 글이 올라오지 않았을 때
        if (snapshot.hasData) {
          print(current_index);
          print("no new");
          return _makeDataList(snapshot);
        }
        if (snapshot.data != null) {
          print("gogoggogo");
        }
        //return _makeDataList(snapshot.data);
        return Center(child: Text("해당 지역에 데이터가 없습니다."));
      },
    );
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 138, 43, 43),
      title: Text("수요 조사"),
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
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Divider(
                  thickness: 1,
                  height: 40,
                  indent: 0.0,
                  endIndent: 0.0,
                  color: Colors.grey),
              Text(
                "출발지 \t\t 도착지 \t\t 날짜  \t\t시간  \t\t남은좌석  \t\t  신청",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Divider(
                  thickness: 1,
                  height: 40,
                  indent: 0.0,
                  endIndent: 0.0,
                  color: Colors.grey),
              Expanded(
                child: _makeDataList(datas),
              )
            ],
          ),
        ));
  }
}
