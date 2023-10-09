import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? messageid;
  String? sender;
  String? text;
  String? lat;
  String? long;
  bool? seen;
  DateTime? createdOn;

  MessageModel(
      {this.messageid, this.sender, this.text, this.lat,this.long, this.seen, this.createdOn});

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageid = map["messageid"];
    sender = map["sender"];
    text = map["text"];
    lat = map["lat"];
    long = map["long"];
    seen = map["seen"];
    createdOn =map["createdOn"].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      "messageid": messageid,
      "sender": sender,
      "text": text,
      "lat" : lat,
      "long": long,
      "seen": seen,
      "createdOn": createdOn
    };
  }
}
