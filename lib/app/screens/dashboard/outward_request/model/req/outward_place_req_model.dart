// To parse this JSON data, do
//
//     final outwardPlaceReqModel = outwardPlaceReqModelFromJson(jsonString);

import 'dart:convert';

OutwardPlaceReqModel outwardPlaceReqModelFromJson(String str) =>
    OutwardPlaceReqModel.fromJson(json.decode(str));

String outwardPlaceReqModelToJson(OutwardPlaceReqModel data) =>
    json.encode(data.toJson());

class OutwardPlaceReqModel {
  String? database;
  int? cocode;
  String? date;
  String? pcode;
  String? vehicletype;
  String? outwardtime;
  String? entryDate;
  int? userId;
  List<Dtlxml>? dtlxml;
  String? deviceID;
  String? version;

  OutwardPlaceReqModel({
    this.database,
    this.cocode,
    this.date,
    this.pcode,
    this.vehicletype,
    this.outwardtime,
    this.entryDate,
    this.userId,
    this.dtlxml,
    this.deviceID,
    this.version,
  });

  factory OutwardPlaceReqModel.fromJson(Map<String, dynamic> json) =>
      OutwardPlaceReqModel(
        database: json["DATABASE"],
        cocode: json["COCODE"],
        date: json["Date"],
        pcode: json["PCODE"],
        vehicletype: json["VEHICLETYPE"],
        outwardtime: json["OUTWARDTIME"],
        entryDate: json["EntryDate"],
        userId: json["UserID"],
        dtlxml:
            List<Dtlxml>.from(json["DTLXML"].map((x) => Dtlxml.fromJson(x))),
        deviceID: json["DeviceID"],
        version: json["Version"],
      );

  Map<String, dynamic> toJson() => {
        "DATABASE": database,
        "COCODE": cocode,
        "Date": date,
        "PCODE": pcode,
        "VEHICLETYPE": vehicletype,
        "OUTWARDTIME": outwardtime,
        "EntryDate": entryDate,
        "UserID": userId,
        "DTLXML": List<dynamic>.from((dtlxml ?? []).map((x) => x.toJson())),
        "DeviceID": deviceID,
        "Version": version,
      };
}

class Dtlxml {
  String? inwno;
  String? lotno;
  String? icode;
  double? qty;
  double? balqty;

  Dtlxml({
    this.inwno,
    this.lotno,
    this.icode,
    this.qty,
    this.balqty,
  });

  factory Dtlxml.fromJson(Map<String, dynamic> json) => Dtlxml(
        inwno: json["INWNO"],
        lotno: json["LOTNO"],
        icode: json["ICODE"],
        qty: json["QTY"],
        balqty: json["BALQTY"],
      );

  Map<String, dynamic> toJson() => {
        "INWNO": inwno,
        "LOTNO": lotno,
        "ICODE": icode,
        "QTY": qty,
        "BALQTY": balqty,
      };
}
