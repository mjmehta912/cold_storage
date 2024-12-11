// To parse this JSON data, do
//
//     final itemsResModel = itemsResModelFromJson(jsonString);

import 'dart:convert';

ItemsResModel itemsResModelFromJson(String str) =>
    ItemsResModel.fromJson(json.decode(str));

String itemsResModelToJson(ItemsResModel data) => json.encode(data.toJson());

class ItemsResModel {
  String? message;
  List<ItemData>? data;

  ItemsResModel({
    this.message,
    this.data,
  });

  factory ItemsResModel.fromJson(Map<String, dynamic> json) => ItemsResModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ItemData>.from(
                json["data"].map((x) => ItemData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
      };
}

class ItemData {
  String? icode;
  String? iname;

  ItemData({
    this.icode,
    this.iname,
  });

  factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
        icode: json["ICODE"],
        iname: json["INAME"],
      );

  Map<String, dynamic> toJson() => {
        "ICODE": icode,
        "INAME": iname,
      };
}
