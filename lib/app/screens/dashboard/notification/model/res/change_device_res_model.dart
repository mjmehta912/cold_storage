// To parse this JSON data, do
//
//     final changeDeviceResModel = changeDeviceResModelFromJson(jsonString);

import 'dart:convert';

ChangeDeviceResModel changeDeviceResModelFromJson(String str) => ChangeDeviceResModel.fromJson(json.decode(str));

String changeDeviceResModelToJson(ChangeDeviceResModel data) => json.encode(data.toJson());

class ChangeDeviceResModel {
  int? requestId;
  int? userId;
  int? status;
  ChangeDeviceMetadata? metadata;

  ChangeDeviceResModel({
    this.requestId,
    this.userId,
    this.status,
    this.metadata,
  });

  factory ChangeDeviceResModel.fromJson(Map<String, dynamic> json) => ChangeDeviceResModel(
    requestId: json["RequestID"],
    userId: json["UserID"],
    status: json["Status"],
    metadata: ChangeDeviceMetadata.fromJson(json["Metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "RequestID": requestId,
    "UserID": userId,
    "Status": status,
    "Metadata": metadata?.toJson(),
  };
}

class ChangeDeviceMetadata {
  String? screenName;
  String? key1;
  String? key2;

  ChangeDeviceMetadata({
    this.screenName,
    this.key1,
    this.key2,
  });

  factory ChangeDeviceMetadata.fromJson(Map<String, dynamic> json) => ChangeDeviceMetadata(
    screenName: json["screenName"],
    key1: json["key1"],
    key2: json["key2"],
  );

  Map<String, dynamic> toJson() => {
    "screenName": screenName,
    "key1": key1,
    "key2": key2,
  };
}
