// To parse this JSON data, do
//
//     final loginRequestModel = loginRequestModelFromJson(jsonString);

import 'dart:convert';

LoginRequestModel loginRequestModelFromJson(String str) =>
    LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) =>
    json.encode(data.toJson());

class LoginRequestModel {
  String? mobileNo;
  String? password;
  String? deviceID;
  String? version;
  String? fcmToken;
  String? reason;
  String? mobileModel;
  Metadata? metadata;

  LoginRequestModel({
    this.mobileNo,
    this.password,
    this.deviceID,
    this.version,
    this.fcmToken,
    this.reason,
    this.mobileModel,
    this.metadata,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        mobileNo: json["MobileNO"],
        password: json["Password"],
        deviceID: json["DeviceID"],
        version: json["Version"],
        fcmToken: json["FCMToken"],
        reason: json["Reason"],
        mobileModel: json["MobileModel"],
        metadata: json["Metadata"] == null
            ? null
            : Metadata.fromJson(json["Metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "MobileNO": mobileNo,
        "Password": password,
        "DeviceID": deviceID,
        "Version": version,
        "FCMToken": fcmToken,
        if (reason != null) "Reason": reason,
        if (mobileModel != null) "MobileModel": mobileModel,
        if (metadata != null) "Metadata": metadata?.toJson(),
      };
}

class Metadata {
  String? notificationId;
  String? mobileNo;
  String? screen;

  Metadata({
    this.notificationId,
    this.mobileNo,
    this.screen,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        notificationId: json["notificationID"],
        mobileNo: json["MobileNO"],
        screen: json["Screen"],
      );

  Map<String, dynamic> toJson() => {
        "notificationID": notificationId,
        "MobileNO": mobileNo,
        "Screen": screen,
      };
}
