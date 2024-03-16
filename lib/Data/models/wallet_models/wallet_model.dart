// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

WalletModel walletModelFromJson(dynamic str) => WalletModel.fromJson(str);

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  WalletData? data;
  dynamic status;
  String? message;
  List<dynamic>? pagination;

  WalletModel({
    this.data,
    this.status,
    this.message,
    this.pagination,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        data: json["data"] == null ? null : WalletData.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
        pagination: json["pagination"] == null
            ? []
            : List<dynamic>.from(json["pagination"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
        "message": message,
        "pagination": pagination == null
            ? []
            : List<dynamic>.from(pagination!.map((x) => x)),
      };
}

class WalletData {
  dynamic id;
  dynamic balance;
  List<Transaction>? transaction;

  WalletData({
    this.id,
    this.balance,
    this.transaction,
  });

  factory WalletData.fromJson(Map<String, dynamic> json) => WalletData(
        id: json["id"],
        balance: json["balance"],
        transaction: json["transaction"] == null
            ? []
            : List<Transaction>.from(
                json["transaction"]!.map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "balance": balance,
        "transaction": transaction == null
            ? []
            : List<dynamic>.from(transaction!.map((x) => x.toJson())),
      };
}

class Transaction {
  dynamic id;
  dynamic balance;
  String? key;
  String? description;

  Transaction({
    this.id,
    this.balance,
    this.key,
    this.description,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        balance: json["balance"],
        key: json["key"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "balance": balance,
        "key": key,
        "description": description,
      };
}
