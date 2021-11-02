// To parse this JSON data, do
//
//     final contactModel = contactModelFromJson(jsonString);

import 'dart:convert';

ContactModel contactModelFromJson(String str) => ContactModel.fromJson(json.decode(str));

String contactModelToJson(ContactModel data) => json.encode(data.toJson());

class ContactModel {
  ContactModel({
    this.status,
    this.contactusdata,
  });

  String? status;
  Contactusdata? contactusdata;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    status: json["status"] == null ? null : json["status"],
    contactusdata: json["contactusdata"] == null ? null : Contactusdata.fromJson(json["contactusdata"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "contactusdata": contactusdata == null ? null : contactusdata!.toJson(),
  };
}

class Contactusdata {
  Contactusdata({
    this.srno,
    this.phno,
    this.email,
    this.addr,
    this.fblink,
    this.instalink,
    this.twitlink,
    this.youtubelink,
    this.linkdinlink,
    this.mapaddr,
  });

  dynamic srno;
  String? phno;
  String? email;
  String? addr;
  String? fblink;
  String? instalink;
  String? twitlink;
  String? youtubelink;
  String? linkdinlink;
  String? mapaddr;

  factory Contactusdata.fromJson(Map<String, dynamic> json) => Contactusdata(
    srno: json["srno"],
    phno: json["phno"] == null ? null : json["phno"],
    email: json["email"] == null ? null : json["email"],
    addr: json["addr"] == null ? null : json["addr"],
    fblink: json["fblink"] == null ? null : json["fblink"],
    instalink: json["instalink"] == null ? null : json["instalink"],
    twitlink: json["twitlink"] == null ? null : json["twitlink"],
    youtubelink: json["youtubelink"] == null ? null : json["youtubelink"],
    linkdinlink: json["linkdinlink"] == null ? null : json["linkdinlink"],
    mapaddr: json["mapaddr"] == null ? null : json["mapaddr"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno,
    "phno": phno == null ? null : phno,
    "email": email == null ? null : email,
    "addr": addr == null ? null : addr,
    "fblink": fblink == null ? null : fblink,
    "instalink": instalink == null ? null : instalink,
    "twitlink": twitlink == null ? null : twitlink,
    "youtubelink": youtubelink == null ? null : youtubelink,
    "linkdinlink": linkdinlink == null ? null : linkdinlink,
    "mapaddr": mapaddr == null ? null : mapaddr,
  };
}
