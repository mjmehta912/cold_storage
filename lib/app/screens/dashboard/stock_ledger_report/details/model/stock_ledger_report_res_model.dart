// To parse this JSON data, do
//
//     final stockLedgerReportResModel = stockLedgerReportResModelFromJson(jsonString);

import 'dart:convert';

StockLedgerReportResModel stockLedgerReportResModelFromJson(String str) => StockLedgerReportResModel.fromJson(json.decode(str));

String stockLedgerReportResModelToJson(StockLedgerReportResModel data) => json.encode(data.toJson());

class StockLedgerReportResModel {
  String? message;
  List<StockLedgerReportData>? data;

  StockLedgerReportResModel({
    this.message,
    this.data,
  });

  factory StockLedgerReportResModel.fromJson(Map<String, dynamic> json) => StockLedgerReportResModel(
    message: json["message"],
    data: json["data"]==null?[]:List<StockLedgerReportData>.from(json["data"].map((x) => StockLedgerReportData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from((data??[]).map((x) => x.toJson())),
  };
}

class StockLedgerReportData {
  String? companyName;
  List<StockItem>? stockItems;

  StockLedgerReportData({
    this.companyName,
    this.stockItems,
  });

  factory StockLedgerReportData.fromJson(Map<String, dynamic> json) => StockLedgerReportData(
    companyName: json["companyName"],
    stockItems: List<StockItem>.from(json["StockItems"].map((x) => StockItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "companyName": companyName,
    "StockItems": List<dynamic>.from((stockItems??[]).map((x) => x.toJson())),
  };
}

class StockItem {
  String? itemName;
  List<ItemStockDetail>? itemStockDetails;
  String? closingStock;

  StockItem({
    this.itemName,
    this.itemStockDetails,
    this.closingStock,
  });

  factory StockItem.fromJson(Map<String, dynamic> json) => StockItem(
    itemName: json["itemName"],
    itemStockDetails: List<ItemStockDetail>.from(json["itemStockDetails"].map((x) => ItemStockDetail.fromJson(x))),
    closingStock: json["closingStock"],
  );

  Map<String, dynamic> toJson() => {
    "itemName": itemName,
    "itemStockDetails": List<dynamic>.from((itemStockDetails??[]).map((x) => x.toJson())),
    "closingStock": closingStock,
  };
}

class ItemStockDetail {
  String? inwno;
  String? idate;
  String? iqty;
  bool? isShowFullList =false;
  List<OutwardList>? outwardList;

  ItemStockDetail({
    this.inwno,
    this.idate,
    this.iqty,
    this.isShowFullList,
    this.outwardList,
  });

  factory ItemStockDetail.fromJson(Map<String, dynamic> json) => ItemStockDetail(
    inwno: json["INWNO"],
    idate: json["IDATE"],
    iqty: json["IQTY"],
    isShowFullList: json["isShowFullList"]=false,
    outwardList: List<OutwardList>.from(json["OutwardList"].map((x) => OutwardList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "INWNO": inwno,
    "IDATE": idate,
    "IQTY": iqty,
    "OutwardList": List<dynamic>.from((outwardList??[]).map((x) => x.toJson())),
  };
}

class OutwardList {
  String? outno;
  String? odate;
  String? oqty;
  String? bqty;

  OutwardList({
    this.outno,
    this.odate,
    this.oqty,
    this.bqty,
  });

  factory OutwardList.fromJson(Map<String, dynamic> json) => OutwardList(
    outno: json["OUTNO"],
    odate: json["ODATE"],
    oqty: json["OQTY"],
    bqty: json["BQTY"],
  );

  Map<String, dynamic> toJson() => {
    "OUTNO": outno,
    "ODATE": odate,
    "OQTY": oqty,
    "BQTY": bqty,
  };
}
