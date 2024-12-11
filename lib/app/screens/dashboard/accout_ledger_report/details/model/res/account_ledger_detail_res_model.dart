// To parse this JSON data, do
//
//     final accountLedgerDetailResModel = accountLedgerDetailResModelFromJson(jsonString);

import 'dart:convert';

AccountLedgerDetailResModel accountLedgerDetailResModelFromJson(String str) => AccountLedgerDetailResModel.fromJson(json.decode(str));

String accountLedgerDetailResModelToJson(AccountLedgerDetailResModel data) => json.encode(data.toJson());

class AccountLedgerDetailResModel {
  bool? success;
  String? message;
  String? opening;
  String? closing;
  String? debit;
  String? credit;
  List<AccountLedgerData>? data;

  AccountLedgerDetailResModel({
    this.success,
    this.message,
    this.opening,
    this.closing,
    this.debit,
    this.credit,
    this.data,
  });

  factory AccountLedgerDetailResModel.fromJson(Map<String, dynamic> json) => AccountLedgerDetailResModel(
    success: json["success"],
    message: json["message"],
    opening: json["opening"],
    closing: json["closing"],
    debit: json["debit"],
    credit: json["credit"],
    data: json["data"]==null?[]:List<AccountLedgerData>.from(json["data"].map((x) => AccountLedgerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "opening": opening,
    "closing": closing,
    "debit": debit,
    "credit": credit,
    "data": List<dynamic>.from((data??[]).map((x) => x.toJson())),
  };
}

class AccountLedgerData {
  String? date;
  String? docno;
  String? narration;
  String? book;
  String? debit;
  String? credit;
  String? balance;
  String? nt;
  String? bookcode;
  String? yearid;

  AccountLedgerData({
    this.date,
    this.docno,
    this.narration,
    this.book,
    this.debit,
    this.credit,
    this.balance,
    this.nt,
    this.bookcode,
    this.yearid,
  });

  factory AccountLedgerData.fromJson(Map<String, dynamic> json) => AccountLedgerData(
    date: json["DATE"],
    docno: json["DOCNO"],
    narration: json["NARRATION"],
    book: json["BOOK"],
    debit: json["DEBIT"],
    credit: json["CREDIT"],
    balance: json["BALANCE"],
    nt: json["NT"],
    bookcode: json["BOOKCODE"],
    yearid: json["YEARID"],
  );

  Map<String, dynamic> toJson() => {
    "DATE": date,
    "DOCNO": docno,
    "NARRATION": narration,
    "BOOK": book,
    "DEBIT": debit,
    "CREDIT": credit,
    "BALANCE": balance,
    "NT": nt,
    "BOOKCODE": bookcode,
    "YEARID": yearid,
  };
}
