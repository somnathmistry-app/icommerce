// To parse this JSON data, do
//
//     final addressAddModel = addressAddModelFromJson(jsonString);

import 'dart:convert';

AddressAddModel addressAddModelFromJson(String str) => AddressAddModel.fromJson(json.decode(str));

String addressAddModelToJson(AddressAddModel data) => json.encode(data.toJson());

class AddressAddModel {
  AddressAddModel({
    this.status,
    this.addressid,
  });

  String? status;
  String? addressid;

  factory AddressAddModel.fromJson(Map<String, dynamic> json) => AddressAddModel(
    status: json["status"] == null ? null : json["status"],
    addressid: json["addressid"] == null ? null : json["addressid"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "addressid": addressid == null ? null : addressid,
  };
}
