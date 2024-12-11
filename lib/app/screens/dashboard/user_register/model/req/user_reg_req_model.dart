// To parse this JSON data, do
//
//     final userRegReqModel = userRegReqModelFromJson(jsonString);

import 'dart:convert';

UserRegReqModel userRegReqModelFromJson(String str) =>
    UserRegReqModel.fromJson(json.decode(str));

String userRegReqModelToJson(UserRegReqModel data) =>
    json.encode(data.toJson());

class UserRegReqModel {
  String? mobileNo;
  String? userName;
  String? password;
  String? panNo;
  int? userType;
  String? pcodEs;
  int? userID;
  String? deviceID;
  String? version;

  UserRegReqModel({
    this.mobileNo,
    this.userName,
    this.password,
    this.panNo,
    this.userType,
    this.pcodEs,
    this.userID,
    this.deviceID,
    this.version,
  });

  factory UserRegReqModel.fromJson(Map<String, dynamic> json) =>
      UserRegReqModel(
        mobileNo: json["MobileNO"],
        userName: json["UserName"],
        password: json["Password"],
        panNo: json["PanNO"],
        userType: json["userType"],
        pcodEs: json["PCODEs"],
        userID: json["UserID"],
        deviceID: json["DeviceID"],
        version: json["Version"],
      );

  Map<String, dynamic> toJson() => {
        "MobileNO": mobileNo,
        "UserName": userName,
        "Password": password,
        "PanNO": panNo,
        "userType": userType,
        "PCODEs": pcodEs,
        "UserID": userID,
        "DeviceID": deviceID,
        "Version": version,
      };
}
