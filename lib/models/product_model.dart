// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.status,
    this.productlist,
  });

  String? status;
  List<Productlist>? productlist;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    status: json["status"] == null ? null : json["status"],
    productlist: json["productlist"] == null ? null : List<Productlist>.from(json["productlist"].map((x) => Productlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "productlist": productlist == null ? null : List<dynamic>.from(productlist!.map((x) => x.toJson())),
  };
}

class Productlist {
  Productlist({
    this.srno,
    this.categoryid,
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
  dynamic subcategoryid;
  String? unitid;
  String? productname;
  dynamic itemqty;
  String? baseprice;
  String? newprice;
  String? discount;
  String? qty;
  String? shortdesc;
  dynamic fulldesc;
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

  factory Productlist.fromJson(Map<String, dynamic> json) => Productlist(
    srno: json["srno"] == null ? null : json["srno"],
    categoryid: json["categoryid"],
    subcategoryid: json["subcategoryid"],
    unitid: json["unitid"] == null ? null : json["unitid"],
    productname: json["productname"] == null ? null : json["productname"],
    itemqty: json["itemqty"],
    baseprice: json["baseprice"] == null ? null : json["baseprice"],
    newprice: json["newprice"] == null ? null : json["newprice"],
    discount: json["discount"] == null ? null : json["discount"],
    qty: json["qty"] == null ? null : json["qty"],
    shortdesc: json["shortdesc"] == null ? null : json["shortdesc"],
    fulldesc: json["fulldesc"],
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
    "subcategoryid": subcategoryid,
    "unitid": unitid == null ? null : unitid,
    "productname": productname == null ? null : productname,
    "itemqty": itemqty,
    "baseprice": baseprice == null ? null : baseprice,
    "newprice": newprice == null ? null : newprice,
    "discount": discount == null ? null : discount,
    "qty": qty == null ? null : qty,
    "shortdesc": shortdesc == null ? null : shortdesc,
    "fulldesc": fulldesc,
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
