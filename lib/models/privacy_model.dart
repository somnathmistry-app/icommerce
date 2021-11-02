// To parse this JSON data, do
//
//     final privacyModel = privacyModelFromJson(jsonString);

import 'dart:convert';

PrivacyModel privacyModelFromJson(String str) => PrivacyModel.fromJson(json.decode(str));

String privacyModelToJson(PrivacyModel data) => json.encode(data.toJson());

class PrivacyModel {
  PrivacyModel({
    this.status,
    this.privacyPolicy,
  });

  String? status;
  String? privacyPolicy;

  factory PrivacyModel.fromJson(Map<String, dynamic> json) => PrivacyModel(
    status: json["status"] == null ? null : json["status"],
    privacyPolicy: json["PrivacyPolicy"] == null ? null : json["PrivacyPolicy"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "PrivacyPolicy": privacyPolicy == null ? null : privacyPolicy,
  };
}
