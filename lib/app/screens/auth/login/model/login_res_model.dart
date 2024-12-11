// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  bool? success;
  String? message;
  String? userName;
  int? userId;
  List<LoginData>? data;

  LoginResponseModel({
    this.success,
    this.message,
    this.userName,
    this.userId,
    this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    success: json["success"],
    message: json["message"],
    userName: json["UserName"]??'',
    userId: json["UserID"]??0,
    data: json["data"]==null?[]:List<LoginData>.from(json["data"].map((x) => LoginData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "UserName": userName,
    "UserID": userId,
    "data": List<dynamic>.from((data??[]).map((x) => x.toJson())),
  };
}

class LoginData {
  String? companyName;
  String? panno;
  String? userType;
  String? dbName;
  int? coCode;

  LoginData({
    this.companyName,
    this.panno,
    this.userType,
    this.dbName,
    this.coCode,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    companyName: json["CompanyName"],
    panno: json["PANNO"],
    userType: json["userType"],
    dbName: json["DBName"],
    coCode: json["CoCode"],
  );

  Map<String, dynamic> toJson() => {
    "CompanyName": companyName,
    "PANNO": panno,
    "userType": userType,
    "DBName": dbName,
    "CoCode": coCode,
  };
}
