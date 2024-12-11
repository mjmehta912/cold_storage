// To parse this JSON data, do
//
//     final authorizedReqModel = authorizedReqModelFromJson(jsonString);

import 'dart:convert';

AuthorizedReqModel authorizedReqModelFromJson(String str) =>
    AuthorizedReqModel.fromJson(json.decode(str));

String authorizedReqModelToJson(AuthorizedReqModel data) =>
    json.encode(data.toJson());

class AuthorizedReqModel {
  String? database;
  int? cocode;
  String? date;
  String? entryDate;
  String? remarks;
  String? invNo;
  int? status;
  int? id;
  int? userID;
  String? deviceID;
  String? version;

  AuthorizedReqModel({
    this.database,
    this.cocode,
    this.date,
    this.entryDate,
    this.remarks,
    this.invNo,
    this.status,
    this.id,
    this.userID,
    this.deviceID,
    this.version,
  });

  factory AuthorizedReqModel.fromJson(Map<String, dynamic> json) =>
      AuthorizedReqModel(
        database: json["DATABASE"],
        cocode: json["COCODE"],
        date: json["Date"],
        entryDate: json["EntryDate"],
        remarks: json["REMARKS"],
        invNo: json["INVNo"],
        status: json["Status"],
        id: json["ID"],
        userID: json["UserID"],
        deviceID: json["DeviceID"],
        version: json["Version"],
      );

  Map<String, dynamic> toJson() => {
        "DATABASE": database,
        "COCODE": cocode,
        "Date": date,
        "EntryDate": entryDate,
        "REMARKS": remarks,
        "INVNo": invNo,
        "Status": status,
        "ID": id,
        "UserID": userID,
        "DeviceID": deviceID,
        "Version": version,
      };
}
