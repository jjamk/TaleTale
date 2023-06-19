import 'package:cloud_firestore/cloud_firestore.dart';

class ListModel {
  ListModel({
    this.date,
    this.time,
    this.arrTer,
    this.startTer,
    this.seatNum,
  });

  String? date;
  String? time;
  String? arrTer;
  String? startTer;
  String? seatNum;

  ListModel.fromJson(dynamic json) {
    date = json['date'];
    time = json['time'];
    arrTer = json['arrTer'];
    startTer = json['startTer'];
    seatNum = json['seatNum'];
  }

  ListModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data());
  ListModel.fromQuerySnapShot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data());
}
