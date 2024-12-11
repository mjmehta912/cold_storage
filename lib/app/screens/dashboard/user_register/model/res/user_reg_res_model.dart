// To parse this JSON data, do
//
//     final userRegResModel = userRegResModelFromJson(jsonString);

import 'dart:convert';

UserRegResModel userRegResModelFromJson(String str) => UserRegResModel.fromJson(json.decode(str));

String userRegResModelToJson(UserRegResModel data) => json.encode(data.toJson());

class UserRegResModel {
  bool? success;
  String? message;

  UserRegResModel({
    this.success,
    this.message,
  });

  factory UserRegResModel.fromJson(Map<String, dynamic> json) => UserRegResModel(
    success: json["success"]??false,
    message: json["message"]??'',
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
