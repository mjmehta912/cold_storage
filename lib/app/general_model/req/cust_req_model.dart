// To parse this JSON data, do
//
//     final custReqModel = custReqModelFromJson(jsonString);

import 'dart:convert';

CustReqModel custReqModelFromJson(String str) =>
    CustReqModel.fromJson(json.decode(str));

String custReqModelToJson(CustReqModel data) => json.encode(data.toJson());

class CustReqModel {
  String? panNo;
  int? userId;

  CustReqModel({
    this.panNo,
    this.userId,
  });

  factory CustReqModel.fromJson(Map<String, dynamic> json) => CustReqModel(
        panNo: json["PanNO"],
        userId: json["UserId"],
      );

  Map<String, dynamic> toJson() => {
        "PanNO": panNo,
        "UserId": userId,
      };
}
