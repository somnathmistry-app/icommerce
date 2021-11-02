// To parse this JSON data, do
//
//     final addToCartModel = addToCartModelFromJson(jsonString);

import 'dart:convert';

AddToCartModel addToCartModelFromJson(String str) => AddToCartModel.fromJson(json.decode(str));

String addToCartModelToJson(AddToCartModel data) => json.encode(data.toJson());

class AddToCartModel {
  AddToCartModel({
    this.status,
    this.cartid,
  });

  String? status;
  String? cartid;

  factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
    status: json["status"] == null ? null : json["status"],
    cartid: json["cartid"] == null ? null : json["cartid"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "cartid": cartid == null ? null : cartid,
  };
}
