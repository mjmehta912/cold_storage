// To parse this JSON data, do
//
//     final stockSummaryDetailsResModel = stockSummaryDetailsResModelFromJson(jsonString);

import 'dart:convert';

StockSummaryDetailsResModel stockSummaryDetailsResModelFromJson(String str) =>
    StockSummaryDetailsResModel.fromJson(json.decode(str));

String stockSummaryDetailsResModelToJson(StockSummaryDetailsResModel data) =>
    json.encode(data.toJson());

class StockSummaryDetailsResModel {
  String? message;
  List<StockSummaryDetailData>? data;

  StockSummaryDetailsResModel({
    this.message,
    this.data,
  });

  factory StockSummaryDetailsResModel.fromJson(Map<String, dynamic> json) =>
      StockSummaryDetailsResModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<StockSummaryDetailData>.from(json["data"].map((x) => StockSummaryDetailData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
      };
}

class StockSummaryDetailData {
  String? companyName;
  List<ItemDatum>? itemData;

  StockSummaryDetailData({
    this.companyName,
    this.itemData,
  });

  factory StockSummaryDetailData.fromJson(Map<String, dynamic> json) => StockSummaryDetailData(
        companyName: json["companyName"],
        itemData: List<ItemDatum>.from(
            json["itemData"].map((x) => ItemDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "itemData": List<dynamic>.from((itemData ?? []).map((x) => x.toJson())),
      };
}

class ItemDatum {
  String? itemName;
  String? opqty;
  String? iqty;
  String? oqty;
  String? bqty;

  ItemDatum({
    this.itemName,
    this.opqty,
    this.iqty,
    this.oqty,
    this.bqty,
  });

  factory ItemDatum.fromJson(Map<String, dynamic> json) => ItemDatum(
        itemName: json["itemName"],
        opqty: json["OPQTY"],
        iqty: json["IQTY"],
        oqty: json["OQTY"],
        bqty: json["BQTY"],
      );

  Map<String, dynamic> toJson() => {
        "itemName": itemName,
        "OPQTY": opqty,
        "IQTY": iqty,
        "OQTY": oqty,
        "BQTY": bqty,
      };
}
