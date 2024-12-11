// To parse this JSON data, do
//
//     final generalReqModel = generalReqModelFromJson(jsonString);

import 'dart:convert';

GeneralReqModel generalReqModelFromJson(String str) =>
    GeneralReqModel.fromJson(json.decode(str));

String generalReqModelToJson(GeneralReqModel data) =>
    json.encode(data.toJson());

class GeneralReqModel {
  String? database;
  int? cocode;
  String? pcode;
  String? invNo;
  String? panNO;
  int? userId;
  String? deviceID;
  String? version;

  GeneralReqModel({
    this.database,
    this.cocode,
    this.pcode,
    this.invNo,
    this.panNO,
    this.userId,
    this.deviceID,
    this.version,
  });

  factory GeneralReqModel.fromJson(Map<String, dynamic> json) =>
      GeneralReqModel(
        database: json["DATABASE"],
        cocode: json["COCODE"],
        pcode: json["PCODE"],
        invNo: json["INVNo"],
        panNO: json["PanNO"],
        userId: json["UserId"],
        deviceID: json["DeviceID"],
        version: json["Version"],
      );

  Map<String, dynamic> toJson() => {
        if ((database ?? '').isNotEmpty) "DATABASE": database,
        if (cocode != null) "COCODE": cocode,
        if ((pcode ?? '').isNotEmpty) "PCODE": pcode,
        if ((invNo ?? '').isNotEmpty) "INVNo": invNo,
        if ((panNO ?? '').isNotEmpty) "PanNO": panNO,
        if (userId!=null) "UserId": userId,
        if (deviceID!=null) "DeviceID": deviceID,
        if (version!=null) "Version": version,
      };
}
