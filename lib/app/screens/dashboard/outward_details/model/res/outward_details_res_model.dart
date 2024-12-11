// To parse this JSON data, do
//
//     final outwardDetailsResModel = outwardDetailsResModelFromJson(jsonString);

import 'dart:convert';

OutwardDetailsResModel outwardDetailsResModelFromJson(String str) =>
    OutwardDetailsResModel.fromJson(json.decode(str));

String outwardDetailsResModelToJson(OutwardDetailsResModel data) =>
    json.encode(data.toJson());

class OutwardDetailsResModel {
  List<OutwardDetailsData>? data;
  bool? success;
  String? message;

  OutwardDetailsResModel({
    this.data,
    this.success,
    this.message,
  });

  factory OutwardDetailsResModel.fromJson(Map<String, dynamic> json) =>
      OutwardDetailsResModel(
        data: json["data"] == null
            ? []
            : List<OutwardDetailsData>.from(
                json["data"].map((x) => OutwardDetailsData.fromJson(x))),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
        "success": success,
        "message": message,
      };
}

class OutwardDetailsData {
  String? invno;
  String? date;
  String? pname;
  String? vehicleType;
  String? outwardTime;
  String? entryDate;
  String? status;
  String? inwno;
  String? lotno;
  String? qty;
  String? balqty;
  String? iname;
  int? id;

  OutwardDetailsData({
    this.invno,
    this.date,
    this.pname,
    this.vehicleType,
    this.outwardTime,
    this.entryDate,
    this.status,
    this.inwno,
    this.lotno,
    this.qty,
    this.balqty,
    this.iname,
    this.id,
  });

  factory OutwardDetailsData.fromJson(Map<String, dynamic> json) =>
      OutwardDetailsData(
        invno: json["INVNO"],
        date: json["Date"],
        pname: json["PNAME"],
        vehicleType: json["VehicleType"],
        outwardTime: json["OutwardTime"],
        entryDate: json["EntryDate"],
        status: json["Status"],
        inwno: json["INWNO"],
        lotno: json["LOTNO"],
        qty: json["QTY"],
        balqty: json["BALQTY"],
        iname: json["INAME"],
        id: json["ID"],
      );

  Map<String, dynamic> toJson() => {
        "INVNO": invno,
        "Date": date,
        "PNAME": pname,
        "VehicleType": vehicleType,
        "OutwardTime": outwardTime,
        "EntryDate": entryDate,
        "Status": status,
        "INWNO": inwno,
        "LOTNO": lotno,
        "QTY": qty,
        "BALQTY": balqty,
        "INAME": iname,
        "ID": id,
      };
}
