// To parse this JSON data, do
//
//     final returnPolicyModel = returnPolicyModelFromJson(jsonString);

import 'dart:convert';

ReturnPolicyModel returnPolicyModelFromJson(String str) => ReturnPolicyModel.fromJson(json.decode(str));

String returnPolicyModelToJson(ReturnPolicyModel data) => json.encode(data.toJson());

class ReturnPolicyModel {
  ReturnPolicyModel({
    this.status,
    this.returnPolicy,
  });

  String? status;
  String? returnPolicy;

  factory ReturnPolicyModel.fromJson(Map<String, dynamic> json) => ReturnPolicyModel(
    status: json["status"] == null ? null : json["status"],
    returnPolicy: json["ReturnPolicy"] == null ? null : json["ReturnPolicy"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "ReturnPolicy": returnPolicy == null ? null : returnPolicy,
  };
}
