// To parse this JSON data, do
//
//     final changeDeviceReqModel = changeDeviceReqModelFromJson(jsonString);

import 'dart:convert';

ChangeDeviceReqModel changeDeviceReqModelFromJson(String str) => ChangeDeviceReqModel.fromJson(json.decode(str));

String changeDeviceReqModelToJson(ChangeDeviceReqModel data) => json.encode(data.toJson());

class ChangeDeviceReqModel {
  String? mobileNo;
  String? deviceId;
  String? reason;
  String? fcmToken;
  NotificationMetadata? metadata;

  ChangeDeviceReqModel({
    this.mobileNo,
    this.deviceId,
    this.reason,
    this.fcmToken,
    this.metadata,
  });

  factory ChangeDeviceReqModel.fromJson(Map<String, dynamic> json) => ChangeDeviceReqModel(
    mobileNo: json["MobileNO"],
    deviceId: json["DeviceID"],
    reason: json["Reason"],
    fcmToken: json["FCMToken"],
    metadata: NotificationMetadata.fromJson(json["Metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "MobileNO": mobileNo,
    "DeviceID": deviceId,
    "Reason": reason,
    "FCMToken": fcmToken,
    "Metadata": metadata?.toJson(),
  };
}

class NotificationMetadata {
  String? notificationId;
  String? mobileNo;
  String? screen;

  NotificationMetadata({
    this.notificationId,
    this.mobileNo,
    this.screen,
  });

  factory NotificationMetadata.fromJson(Map<String, dynamic> json) => NotificationMetadata(
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
