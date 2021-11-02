// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.status,
    this.sliderlist,
    this.topcatlist,
    this.banner1,
    this.banner2,
    this.catlist,
    this.recentprd,
    this.similarprd,
  });

  String? status;
  List<Sliderlist>? sliderlist;
  List<Catlist>? topcatlist;
  Banner? banner1;
  Banner? banner2;
  List<Catlist>? catlist;
  List<dynamic>? recentprd;
  List<dynamic>? similarprd;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    status: json["status"] == null ? null : json["status"],
    sliderlist: json["sliderlist"] == null ? null : List<Sliderlist>.from(json["sliderlist"].map((x) => Sliderlist.fromJson(x))),
    topcatlist: json["topcatlist"] == null ? null : List<Catlist>.from(json["topcatlist"].map((x) => Catlist.fromJson(x))),
    banner1: json["banner1"] == null ? null : Banner.fromJson(json["banner1"]),
    banner2: json["banner2"] == null ? null : Banner.fromJson(json["banner2"]),
    catlist: json["catlist"] == null ? null : List<Catlist>.from(json["catlist"].map((x) => Catlist.fromJson(x))),
    recentprd: json["recentprd"] == null ? null : List<dynamic>.from(json["recentprd"].map((x) => x)),
    similarprd: json["similarprd"] == null ? null : List<dynamic>.from(json["similarprd"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "sliderlist": sliderlist == null ? null : List<dynamic>.from(sliderlist!.map((x) => x.toJson())),
    "topcatlist": topcatlist == null ? null : List<dynamic>.from(topcatlist!.map((x) => x.toJson())),
    "banner1": banner1 == null ? null : banner1!.toJson(),
    "banner2": banner2 == null ? null : banner2!.toJson(),
    "catlist": catlist == null ? null : List<dynamic>.from(catlist!.map((x) => x.toJson())),
    "recentprd": recentprd == null ? null : List<dynamic>.from(recentprd!.map((x) => x)),
    "similarprd": similarprd == null ? null : List<dynamic>.from(similarprd!.map((x) => x)),
  };
}

class Banner {
  Banner({
    this.srno,
    this.imgurl,
    this.imgposition,
  });

  dynamic srno;
  String? imgurl;
  dynamic imgposition;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    srno: json["srno"],
    imgurl: json["imgurl"] == null ? null : json["imgurl"],
    imgposition: json["imgposition"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno,
    "imgurl": imgurl == null ? null : imgurl,
    "imgposition": imgposition,
  };
}

class Catlist {
  Catlist({
    this.srno,
    this.name,
    this.image,
    this.image1,
    this.isActive,
  });

  String? srno;
  String? name;
  String? image;
  dynamic image1;
  dynamic isActive;

  factory Catlist.fromJson(Map<String, dynamic> json) => Catlist(
    srno: json["srno"] == null ? null : json["srno"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    image1: json["image1"],
    isActive: json["IsActive"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno == null ? null : srno,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "image1": image1,
    "IsActive": isActive,
  };
}

class Sliderlist {
  Sliderlist({
    this.srno,
    this.imgurl,
    this.isactive,
  });

  String? srno;
  String? imgurl;
  dynamic isactive;

  factory Sliderlist.fromJson(Map<String, dynamic> json) => Sliderlist(
    srno: json["srno"] == null ? null : json["srno"],
    imgurl: json["imgurl"] == null ? null : json["imgurl"],
    isactive: json["isactive"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno == null ? null : srno,
    "imgurl": imgurl == null ? null : imgurl,
    "isactive": isactive,
  };
}
