// To parse this JSON data, do
//
//     final inwardStockLedgerDetailResModel = inwardStockLedgerDetailResModelFromJson(jsonString);

import 'dart:convert';

InwardStockLedgerDetailResModel inwardStockLedgerDetailResModelFromJson(
        String str) =>
    InwardStockLedgerDetailResModel.fromJson(json.decode(str));

String inwardStockLedgerDetailResModelToJson(
        InwardStockLedgerDetailResModel data) =>
    json.encode(data.toJson());

class InwardStockLedgerDetailResModel {
  String? message;
  List<InwardStockLedgerData>? data;

  InwardStockLedgerDetailResModel({
    this.message,
    this.data,
  });

  factory InwardStockLedgerDetailResModel.fromJson(Map<String, dynamic> json) =>
      InwardStockLedgerDetailResModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<InwardStockLedgerData>.from(
                json["data"].map((x) => InwardStockLedgerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
      };
}

class InwardStockLedgerData {
  String? companyName;
  List<InwardItemsDetail>? inwardItemsDetail;

  InwardStockLedgerData({
    this.companyName,
    this.inwardItemsDetail,
  });

  factory InwardStockLedgerData.fromJson(Map<String, dynamic> json) =>
      InwardStockLedgerData(
        companyName: json["companyName"],
        inwardItemsDetail: List<InwardItemsDetail>.from(
            json["InwardItemsDetail"]
                .map((x) => InwardItemsDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "InwardItemsDetail": List<dynamic>.from(
            (inwardItemsDetail ?? []).map((x) => x.toJson())),
      };
}

class InwardItemsDetail {
  String? itemName;
  List<InwardDetail>? inwardDetail;
  String? closingStock;

  InwardItemsDetail({
    this.itemName,
    this.inwardDetail,
    this.closingStock,
  });

  factory InwardItemsDetail.fromJson(Map<String, dynamic> json) =>
      InwardItemsDetail(
        itemName: json["itemName"],
        inwardDetail: List<InwardDetail>.from(
            json["InwardDetail"].map((x) => InwardDetail.fromJson(x))),
        closingStock: json["closingStock"],
      );

  Map<String, dynamic> toJson() => {
        "itemName": itemName,
        "InwardDetail":
            List<dynamic>.from((inwardDetail ?? []).map((x) => x.toJson())),
        "closingStock": closingStock,
      };
}

class InwardDetail {
  String? inwno;
  String? idate;
  String? opqty;
  String? iqty;
  String? oqty;
  String? bqty;

  InwardDetail({
    this.inwno,
    this.idate,
    this.opqty,
    this.iqty,
    this.oqty,
    this.bqty,
  });

  factory InwardDetail.fromJson(Map<String, dynamic> json) => InwardDetail(
        inwno: json["INWNO"],
        idate: json["IDATE"],
        opqty: json["OPQTY"],
        iqty: json["IQTY"],
        oqty: json["OQTY"],
        bqty: json["BQTY"],
      );

  Map<String, dynamic> toJson() => {
        "INWNO": inwno,
        "IDATE": idate,
        "OPQTY": opqty,
        "IQTY": iqty,
        "OQTY": oqty,
        "BQTY": bqty,
      };
}
