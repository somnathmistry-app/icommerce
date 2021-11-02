// To parse this JSON data, do
//
//     final faqListModel = faqListModelFromJson(jsonString);

import 'dart:convert';

FaqListModel faqListModelFromJson(String str) => FaqListModel.fromJson(json.decode(str));

String faqListModelToJson(FaqListModel data) => json.encode(data.toJson());

class FaqListModel {
  FaqListModel({
    this.status,
    this.faqcatlist,
    this.faqlist,
  });

  String? status;
  List<Faqcatlist>? faqcatlist;
  List<Faqlist>? faqlist;

  factory FaqListModel.fromJson(Map<String, dynamic> json) => FaqListModel(
    status: json["status"] == null ? null : json["status"],
    faqcatlist: json["faqcatlist"] == null ? null : List<Faqcatlist>.from(json["faqcatlist"].map((x) => Faqcatlist.fromJson(x))),
    faqlist: json["faqlist"] == null ? null : List<Faqlist>.from(json["faqlist"].map((x) => Faqlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "faqcatlist": faqcatlist == null ? null : List<dynamic>.from(faqcatlist!.map((x) => x.toJson())),
    "faqlist": faqlist == null ? null : List<dynamic>.from(faqlist!.map((x) => x.toJson())),
  };
}

class Faqcatlist {
  Faqcatlist({
    this.srno,
    this.name,
    this.isActive,
  });

  String? srno;
  String? name;
  dynamic isActive;

  factory Faqcatlist.fromJson(Map<String, dynamic> json) => Faqcatlist(
    srno: json["srno"] == null ? null : json["srno"],
    name: json["name"] == null ? null : json["name"],
    isActive: json["IsActive"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno == null ? null : srno,
    "name": name == null ? null : name,
    "IsActive": isActive,
  };
}

class Faqlist {
  Faqlist({
    this.srno,
    this.faqcatid,
    this.question,
    this.answer,
    this.isActive,
  });

  String? srno;
  String? faqcatid;
  String? question;
  String? answer;
  dynamic isActive;

  factory Faqlist.fromJson(Map<String, dynamic> json) => Faqlist(
    srno: json["srno"] == null ? null : json["srno"],
    faqcatid: json["faqcatid"] == null ? null : json["faqcatid"],
    question: json["question"] == null ? null : json["question"],
    answer: json["answer"] == null ? null : json["answer"],
    isActive: json["IsActive"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno == null ? null : srno,
    "faqcatid": faqcatid == null ? null : faqcatid,
    "question": question == null ? null : question,
    "answer": answer == null ? null : answer,
    "IsActive": isActive,
  };
}
