// To parse this JSON data, do
//
//     final notificationResModel = notificationResModelFromJson(jsonString);

import 'dart:convert';

NotificationResModel notificationResModelFromJson(String str) =>
    NotificationResModel.fromJson(json.decode(str));

String notificationResModelToJson(NotificationResModel data) =>
    json.encode(data.toJson());

class NotificationResModel {
  bool? success;
  String? message;
  List<NotificationData>? data;

  NotificationResModel({
    this.success,
    this.message,
    this.data,
  });

  factory NotificationResModel.fromJson(Map<String, dynamic> json) =>
      NotificationResModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<NotificationData>.from(
                json["data"].map((x) => NotificationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
      };
}

class NotificationData {
  int? requestId;
  int? userId;
  String? userName;
  String? mobileNo;
  String? reason;
  int? status;
  String? updateBy;
  String? timeStamp;
  String? mobileModel;

  NotificationData({
    this.requestId,
    this.userId,
    this.userName,
    this.mobileNo,
    this.reason,
    this.status,
    this.updateBy,
    this.timeStamp,
    this.mobileModel,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        requestId: json["RequestID"],
        userId: json["UserID"],
        userName: json["UserName"],
        mobileNo: json["MobileNO"],
        reason: json["Reason"],
        status: json["Status"],
        updateBy: json["UpdateBy"],
        timeStamp: json["TimeStamp"],
        mobileModel: json["MobileModel"],
      );

  Map<String, dynamic> toJson() => {
        "RequestID": requestId,
        "UserID": userId,
        "UserName": userName,
        "MobileNO": mobileNo,
        "Reason": reason,
        "Status": status,
        "UpdateBy": updateBy,
        "TimeStamp": timeStamp,
        "MobileModel": mobileModel,
      };
}
