// To parse this JSON data, do
//
//     final notificationListModel = notificationListModelFromJson(jsonString);

import 'dart:convert';

NotificationListModel notificationListModelFromJson(String str) => NotificationListModel.fromJson(json.decode(str));

String notificationListModelToJson(NotificationListModel data) => json.encode(data.toJson());

class NotificationListModel {
  NotificationListModel({
    this.status,
    this.notificationlist,
  });

  String? status;
  List<Notificationlist>? notificationlist;

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
    status: json["status"] == null ? null : json["status"],
    notificationlist: json["notificationlist"] == null ? null : List<Notificationlist>.from(json["notificationlist"].map((x) => Notificationlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "notificationlist": notificationlist == null ? null : List<dynamic>.from(notificationlist!.map((x) => x.toJson())),
  };
}

class Notificationlist {
  Notificationlist({
    this.srno,
    this.userid,
    this.catid,
    this.prdid,
    this.ntype,
    this.heading,
    this.shortdesc,
    this.ondate,
    this.isactive,
    this.fromdate,
    this.todate,
    this.imgurl,
    this.catprdname,
    this.catprdid,
    this.catprdimg,
  });

  String? srno;
  String? userid;
  dynamic catid;
  dynamic prdid;
  String? ntype;
  String? heading;
  String? shortdesc;
  String? ondate;
  dynamic isactive;
  String? fromdate;
  String? todate;
  String? imgurl;
  String? catprdname;
  String? catprdid;
  String? catprdimg;

  factory Notificationlist.fromJson(Map<String, dynamic> json) => Notificationlist(
    srno: json["srno"] == null ? null : json["srno"],
    userid: json["userid"] == null ? null : json["userid"],
    catid: json["catid"],
    prdid: json["prdid"],
    ntype: json["ntype"] == null ? null : json["ntype"],
    heading: json["heading"] == null ? null : json["heading"],
    shortdesc: json["shortdesc"] == null ? null : json["shortdesc"],
    ondate: json["ondate"] == null ? null : json["ondate"],
    isactive: json["isactive"],
    fromdate: json["fromdate"] == null ? null : json["fromdate"],
    todate: json["todate"] == null ? null : json["todate"],
    imgurl: json["imgurl"] == null ? null : json["imgurl"],
    catprdname: json["catprdname"] == null ? null : json["catprdname"],
    catprdid: json["catprdid"] == null ? null : json["catprdid"],
    catprdimg: json["catprdimg"] == null ? null : json["catprdimg"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno == null ? null : srno,
    "userid": userid == null ? null : userid,
    "catid": catid,
    "prdid": prdid,
    "ntype": ntype == null ? null : ntype,
    "heading": heading == null ? null : heading,
    "shortdesc": shortdesc == null ? null : shortdesc,
    "ondate": ondate == null ? null : ondate,
    "isactive": isactive,
    "fromdate": fromdate == null ? null : fromdate,
    "todate": todate == null ? null : todate,
    "imgurl": imgurl == null ? null : imgurl,
    "catprdname": catprdname == null ? null : catprdname,
    "catprdid": catprdid == null ? null : catprdid,
    "catprdimg": catprdimg == null ? null : catprdimg,
  };
}
