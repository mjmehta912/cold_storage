// To parse this JSON data, do
//
//     final inwardNoResModel = inwardNoResModelFromJson(jsonString);

import 'dart:convert';

InwardNoResModel inwardNoResModelFromJson(String str) =>
    InwardNoResModel.fromJson(json.decode(str));

String inwardNoResModelToJson(InwardNoResModel data) =>
    json.encode(data.toJson());

class InwardNoResModel {
  bool? success;
  String? message;
  List<InwardNoData>? data;

  InwardNoResModel({
    this.success,
    this.message,
    this.data,
  });

  factory InwardNoResModel.fromJson(Map<String, dynamic> json) =>
      InwardNoResModel(
        success: json["success"],
        message: json["message"],
        data: json["data"]==null?[]:List<InwardNoData>.from(json["data"].map((x) => InwardNoData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
      };
}

class InwardNoData {
  String? invno;
  String? balance;

  InwardNoData({
    this.invno,
    this.balance,
  });

  factory InwardNoData.fromJson(Map<String, dynamic> json) => InwardNoData(
        invno: json["INVNO"],
        balance: json["BALANCE"],
      );

  Map<String, dynamic> toJson() => {
        "INVNO": invno,
        "BALANCE": balance,
      };
}
