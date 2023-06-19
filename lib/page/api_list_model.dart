import 'package:cloud_firestore/cloud_firestore.dart';

class ApiListModel {
  ApiListModel({
    this.date,
    this.time,
    this.arrTer,
    this.startTer,
    this.seatNum,
    this.rotSqno,
    this.alcnSqno,
    this.price,
    this.rotId,
  });

  String? date;
  String? time;
  String? arrTer;
  String? startTer;
  String? seatNum;
  String? rotSqno;
  String? alcnSqno;
  String? price;
  String? rotId;

  ApiListModel.fromJson(dynamic json) {
    date = json['date'];
    time = json['time'];
    arrTer = json['arrTer'];
    startTer = json['startTer'];
    seatNum = json['seatNum'];
    price = json['price'];
    rotSqno = json['rotSqno'];
    alcnSqno = json['alcnSqno'];
    rotId = json['rotId'];
  }

  ApiListModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data());
  ApiListModel.fromQuerySnapShot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data());
}
