// To parse this JSON data, do
//
//     final termsconditionModel = termsconditionModelFromJson(jsonString);

import 'dart:convert';

TermsconditionModel termsconditionModelFromJson(String str) => TermsconditionModel.fromJson(json.decode(str));

String termsconditionModelToJson(TermsconditionModel data) => json.encode(data.toJson());

class TermsconditionModel {
  TermsconditionModel({
    this.status,
    this.termscondition,
  });

  String? status;
  String? termscondition;

  factory TermsconditionModel.fromJson(Map<String, dynamic> json) => TermsconditionModel(
    status: json["status"] == null ? null : json["status"],
    termscondition: json["termscondition"] == null ? null : json["termscondition"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "termscondition": termscondition == null ? null : termscondition,
  };
}
