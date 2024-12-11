// To parse this JSON data, do
//
//     final getInwardStockLedgerReqModel = getInwardStockLedgerReqModelFromJson(jsonString);

import 'dart:convert';

GetInwardStockLedgerReqModel getInwardStockLedgerReqModelFromJson(String str) =>
    GetInwardStockLedgerReqModel.fromJson(json.decode(str));

String getInwardStockLedgerReqModelToJson(GetInwardStockLedgerReqModel data) =>
    json.encode(data.toJson());

class GetInwardStockLedgerReqModel {
  String? fromDate;
  String? toDate;
  int? viewBy;
  int? show;
  String? pCodes;
  String? PCODE;
  String? iCodes;
  String? invno;
  String? dbName;
  int? coCode;
  int? closing;
  int? userID;
  String? deviceID;
  String? version;

  GetInwardStockLedgerReqModel({
    this.fromDate,
    this.toDate,
    this.viewBy,
    this.show,
    this.pCodes,
    this.PCODE,
    this.iCodes,
    this.invno,
    this.dbName,
    this.coCode,
    this.closing,
    this.userID,
    this.deviceID,
    this.version,
  });

  factory GetInwardStockLedgerReqModel.fromJson(Map<String, dynamic> json) =>
      GetInwardStockLedgerReqModel(
        fromDate: json["FromDate"],
        toDate: json["ToDate"],
        viewBy: json["ViewBy"],
        show: json["Show"],
        pCodes: json["PCodes"],
        PCODE: json["PCODE"],
        iCodes: json["ICodes"],
        invno: json["Invno"],
        dbName: json["DBName"],
        coCode: json["CoCode"],
        closing: json["Closing"],
        userID: json["UserID"],
        deviceID: json["DeviceID"],
        version: json["Version"],
      );

  Map<String, dynamic> toJson() => {
        if (fromDate != null) "FromDate": fromDate,
        if (toDate != null) "ToDate": toDate,
        if (viewBy != null) "ViewBy": viewBy,
        if (show != null) "Show": show,
        if (pCodes != null) "PCodes": pCodes,
        if (PCODE != null) "PCODE": PCODE,
        if (iCodes != null) "ICodes": iCodes,
        if (invno != null) "Invno": invno,
        if (dbName != null) "DBName": dbName,
        if (coCode != null) "CoCode": coCode,
        if (closing != null) "Closing": closing,
        if (userID != null) "UserID": userID,
        if (deviceID != null) "DeviceID": deviceID,
        if (deviceID != null) "DeviceID": deviceID,
        if (version != null) "Version": version,
      };
}
