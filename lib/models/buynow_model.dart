// To parse this JSON data, do
//
//     final buyNowModel = buyNowModelFromJson(jsonString);

import 'dart:convert';

BuyNowModel buyNowModelFromJson(String str) => BuyNowModel.fromJson(json.decode(str));

String buyNowModelToJson(BuyNowModel data) => json.encode(data.toJson());

class BuyNowModel {
  BuyNowModel({
    this.status,
    this.cartid,
  });

  String? status;
  String? cartid;

  factory BuyNowModel.fromJson(Map<String, dynamic> json) => BuyNowModel(
    status: json["status"] == null ? null : json["status"],
    cartid: json["cartid"] == null ? null : json["cartid"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "cartid": cartid == null ? null : cartid,
  };
}
