// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  ProductDetailsModel({
    this.status,
    this.prddata,
    this.similarprdlist,
    this.prdimglist,
    this.reviewlist,
  });

  String? status;
  Prddata? prddata;
  List<Prddata>? similarprdlist;
  List<Prdimglist>? prdimglist;
  List<Reviewlist>? reviewlist;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
    status: json["status"] == null ? null : json["status"],
    prddata: json["prddata"] == null ? null : Prddata.fromJson(json["prddata"]),
    similarprdlist: json["similarprdlist"] == null ? null : List<Prddata>.from(json["similarprdlist"].map((x) => Prddata.fromJson(x))),
    prdimglist: json["prdimglist"] == null ? null : List<Prdimglist>.from(json["prdimglist"].map((x) => Prdimglist.fromJson(x))),
    reviewlist: json["reviewlist"] == null ? null : List<Reviewlist>.from(json["reviewlist"].map((x) => Reviewlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "prddata": prddata == null ? null : prddata!.toJson(),
    "similarprdlist": similarprdlist == null ? null : List<dynamic>.from(similarprdlist!.map((x) => x.toJson())),
    "prdimglist": prdimglist == null ? null : List<dynamic>.from(prdimglist!.map((x) => x.toJson())),
    "reviewlist": reviewlist == null ? null : List<dynamic>.from(reviewlist!.map((x) => x.toJson())),
  };
}

class Prddata {
  Prddata({
    this.srno,
    this.categoryid,
    this.category,
    this.subcategoryid,
    this.unitid,
    this.productname,
    this.itemqty,
    this.baseprice,
    this.newprice,
    this.discount,
    this.qty,
    this.shortdesc,
    this.fulldesc,
    this.thumbimg,
    this.thumbimg1,
    this.isActive,
    this.ondate,
    this.additionalimg,
    this.flashsale,
    this.sellerid,
    this.taxrate,
    this.iswishlisted,
    this.businessname,
    this.businessimg,
    this.avgrating,
    this.reviewcount,
  });

  String? srno;
  dynamic categoryid;
  dynamic category;
  dynamic subcategoryid;
  String? unitid;
  String? productname;
  dynamic itemqty;
  String? baseprice;
  String? newprice;
  String? discount;
  String? qty;
  String? shortdesc;
  String? fulldesc;
  String? thumbimg;
  dynamic thumbimg1;
  String? isActive;
  dynamic ondate;
  dynamic additionalimg;
  dynamic flashsale;
  dynamic sellerid;
  dynamic taxrate;
  bool? iswishlisted;
  String? businessname;
  String? businessimg;
  String? avgrating;
  String? reviewcount;

  factory Prddata.fromJson(Map<String, dynamic> json) => Prddata(
    srno: json["srno"] == null ? null : json["srno"],
    categoryid: json["categoryid"],
    category: json["category"],
    subcategoryid: json["subcategoryid"],
    unitid: json["unitid"] == null ? null : json["unitid"],
    productname: json["productname"] == null ? null : json["productname"],
    itemqty: json["itemqty"],
    baseprice: json["baseprice"] == null ? null : json["baseprice"],
    newprice: json["newprice"] == null ? null : json["newprice"],
    discount: json["discount"] == null ? null : json["discount"],
    qty: json["qty"] == null ? null : json["qty"],
    shortdesc: json["shortdesc"] == null ? null : json["shortdesc"],
    fulldesc: json["fulldesc"] == null ? null : json["fulldesc"],
    thumbimg: json["thumbimg"] == null ? null : json["thumbimg"],
    thumbimg1: json["thumbimg1"],
    isActive: json["IsActive"] == null ? null : json["IsActive"],
    ondate: json["ondate"],
    additionalimg: json["additionalimg"],
    flashsale: json["flashsale"],
    sellerid: json["sellerid"],
    taxrate: json["taxrate"],
    iswishlisted: json["iswishlisted"] == null ? null : json["iswishlisted"],
    businessname: json["businessname"] == null ? null : json["businessname"],
    businessimg: json["businessimg"] == null ? null : json["businessimg"],
    avgrating: json["avgrating"] == null ? null : json["avgrating"],
    reviewcount: json["reviewcount"] == null ? null : json["reviewcount"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno == null ? null : srno,
    "categoryid": categoryid,
    "category": category,
    "subcategoryid": subcategoryid,
    "unitid": unitid == null ? null : unitid,
    "productname": productname == null ? null : productname,
    "itemqty": itemqty,
    "baseprice": baseprice == null ? null : baseprice,
    "newprice": newprice == null ? null : newprice,
    "discount": discount == null ? null : discount,
    "qty": qty == null ? null : qty,
    "shortdesc": shortdesc == null ? null : shortdesc,
    "fulldesc": fulldesc == null ? null : fulldesc,
    "thumbimg": thumbimg == null ? null : thumbimg,
    "thumbimg1": thumbimg1,
    "IsActive": isActive == null ? null : isActive,
    "ondate": ondate,
    "additionalimg": additionalimg,
    "flashsale": flashsale,
    "sellerid": sellerid,
    "taxrate": taxrate,
    "iswishlisted": iswishlisted == null ? null : iswishlisted,
    "businessname": businessname == null ? null : businessname,
    "businessimg": businessimg == null ? null : businessimg,
    "avgrating": avgrating == null ? null : avgrating,
    "reviewcount": reviewcount == null ? null : reviewcount,
  };
}

class Prdimglist {
  Prdimglist({
    this.srno,
    this.imgurl,
  });

  String? srno;
  String? imgurl;

  factory Prdimglist.fromJson(Map<String, dynamic> json) => Prdimglist(
    srno: json["srno"] == null ? null : json["srno"],
    imgurl: json["imgurl"] == null ? null : json["imgurl"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno == null ? null : srno,
    "imgurl": imgurl == null ? null : imgurl,
  };
}

class Reviewlist {
  Reviewlist({
    this.srno,
    this.productid,
    this.productname,
    this.prdimg,
    this.name,
    this.email,
    this.userid,
    this.review,
    this.star,
    this.isActive,
    this.userpic,
    this.ondate,
    this.isBuyer,
  });

  String? srno;
  String? productid;
  dynamic productname;
  dynamic prdimg;
  String? name;
  String? email;
  String? userid;
  String? review;
  String? star;
  dynamic isActive;
  String? userpic;
  String? ondate;
  dynamic isBuyer;

  factory Reviewlist.fromJson(Map<String, dynamic> json) => Reviewlist(
    srno: json["srno"] == null ? null : json["srno"],
    productid: json["productid"] == null ? null : json["productid"],
    productname: json["productname"],
    prdimg: json["prdimg"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    userid: json["userid"] == null ? null : json["userid"],
    review: json["review"] == null ? null : json["review"],
    star: json["star"] == null ? null : json["star"],
    isActive: json["IsActive"],
    userpic: json["userpic"] == null ? null : json["userpic"],
    ondate: json["ondate"] == null ? null : json["ondate"],
    isBuyer: json["IsBuyer"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno == null ? null : srno,
    "productid": productid == null ? null : productid,
    "productname": productname,
    "prdimg": prdimg,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "userid": userid == null ? null : userid,
    "review": review == null ? null : review,
    "star": star == null ? null : star,
    "IsActive": isActive,
    "userpic": userpic == null ? null : userpic,
    "ondate": ondate == null ? null : ondate,
    "IsBuyer": isBuyer,
  };
}
