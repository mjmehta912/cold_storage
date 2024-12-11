// To parse this JSON data, do
//
//     final generalResModel = generalResModelFromJson(jsonString);

import 'dart:convert';

GeneralResModel generalResModelFromJson(String str) =>
    GeneralResModel.fromJson(json.decode(str));

String generalResModelToJson(GeneralResModel data) =>
    json.encode(data.toJson());

class GeneralResModel {
  bool? success;
  String? message;

  GeneralResModel({
    this.success,
    this.message,
  });

  factory GeneralResModel.fromJson(Map<String, dynamic> json) =>
      GeneralResModel(
        success: json["success"] ?? false,
        message: json["message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
