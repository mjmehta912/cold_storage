// To parse this JSON data, do
//
//     final lotNoResModel = lotNoResModelFromJson(jsonString);

import 'dart:convert';

LotNoResModel lotNoResModelFromJson(String str) =>
    LotNoResModel.fromJson(json.decode(str));

String lotNoResModelToJson(LotNoResModel data) => json.encode(data.toJson());

class LotNoResModel {
  bool? success;
  String? message;
  List<String>? data;

  LotNoResModel({
    this.success,
    this.message,
    this.data,
  });

  factory LotNoResModel.fromJson(Map<String, dynamic> json) => LotNoResModel(
        success: json["success"],
        message: json["message"],
        data: List<String>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from((data ?? []).map((x) => x)),
      };
}
