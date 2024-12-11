// To parse this JSON data, do
//
//     final itemsReqModel = itemsReqModelFromJson(jsonString);

import 'dart:convert';

ItemsReqModel itemsReqModelFromJson(String str) => ItemsReqModel.fromJson(json.decode(str));

String itemsReqModelToJson(ItemsReqModel data) => json.encode(data.toJson());

class ItemsReqModel {
  String? pCodes;
  String? dbName;
  int? coCode;

  ItemsReqModel({
    this.pCodes,
    this.dbName,
    this.coCode,
  });

  factory ItemsReqModel.fromJson(Map<String, dynamic> json) => ItemsReqModel(
    pCodes: json["PCodes"],
    dbName: json["DBName"],
    coCode: json["CoCode"],
  );

  Map<String, dynamic> toJson() => {
    "PCodes": pCodes,
    "DBName": dbName,
    "CoCode": coCode,
  };
}
