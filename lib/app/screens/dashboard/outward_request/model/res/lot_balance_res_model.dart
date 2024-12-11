// To parse this JSON data, do
//
//     final lotBalanceResModel = lotBalanceResModelFromJson(jsonString);

import 'dart:convert';

LotBalanceResModel lotBalanceResModelFromJson(String str) => LotBalanceResModel.fromJson(json.decode(str));

String lotBalanceResModelToJson(LotBalanceResModel data) => json.encode(data.toJson());

class LotBalanceResModel {
  bool? success;
  String? message;
  List<LotBalanceData>? data;

  LotBalanceResModel({
    this.success,
    this.message,
    this.data,
  });

  factory LotBalanceResModel.fromJson(Map<String, dynamic> json) => LotBalanceResModel(
    success: json["success"],
    message: json["message"],
    data:json["data"]==null?[]: List<LotBalanceData>.from(json["data"].map((x) => LotBalanceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from((data??[]).map((x) => x.toJson())),
  };
}

class LotBalanceData {
  String? iname;
  String? icode;
  String? balance;

  LotBalanceData({
    this.iname,
    this.icode,
    this.balance,
  });

  factory LotBalanceData.fromJson(Map<String, dynamic> json) => LotBalanceData(
    iname: json["INAME"],
    icode: json["ICODE"],
    balance: json["BALANCE"],
  );

  Map<String, dynamic> toJson() => {
    "INAME": iname,
    "ICODE": icode,
    "BALANCE": balance,
  };
}
