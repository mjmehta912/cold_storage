// To parse this JSON data, do
//
//     final custModel = custModelFromJson(jsonString);

import 'dart:convert';

CustResModel custResModelFromJson(String str) =>
    CustResModel.fromJson(json.decode(str));

String custResModelToJson(CustResModel data) => json.encode(data.toJson());

class CustResModel {
  bool? success;
  String? message;
  dynamic data;
  List<CustomerData>? customerList;

  CustResModel({
    this.success,
    this.message,
    this.data,
    this.customerList,
  });

  factory CustResModel.fromJson(Map<String, dynamic> json) => CustResModel(
        success: json["success"] ?? '',
        message: json["message"] ?? '',
        data: json["data"] ?? '',
        customerList: json["customerList"] == null
            ? []
            : List<CustomerData>.from(
                json["customerList"].map((x) => CustomerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
        "customerList":
            List<dynamic>.from((customerList ?? []).map((x) => x.toJson())),
      };
}

class CustomerData {
  String? pcode;
  String? pname;

  CustomerData({
    this.pcode,
    this.pname,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
        pcode: json["PCODE"],
        pname: json["PNAME"],
      );

  Map<String, dynamic> toJson() => {
        "PCODE": pcode,
        "PNAME": pname,
      };
}
