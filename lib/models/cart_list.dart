// To parse this JSON data, do
//
//     final cartListModel = cartListModelFromJson(jsonString);

import 'dart:convert';

CartListModel cartListModelFromJson(String str) => CartListModel.fromJson(json.decode(str));

String cartListModelToJson(CartListModel data) => json.encode(data.toJson());

class CartListModel {
  CartListModel({
    this.status,
    this.cartlist,
    this.totprice,
    this.totmrp,
    this.tosavings,
  });

  String? status;
  List<Cartlist>? cartlist;
  double? totprice;
  double? totmrp;
  double? tosavings;

  factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
    status: json["status"] == null ? null : json["status"],
    cartlist: json["cartlist"] == null ? null : List<Cartlist>.from(json["cartlist"].map((x) => Cartlist.fromJson(x))),
    totprice: json["totprice"] == null ? null : json["totprice"],
    totmrp: json["totmrp"] == null ? null : json["totmrp"],
    tosavings: json["tosavings"] == null ? null : json["tosavings"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "cartlist": cartlist == null ? null : List<dynamic>.from(cartlist!.map((x) => x.toJson())),
    "totprice": totprice == null ? null : totprice,
    "totmrp": totmrp == null ? null : totmrp,
    "tosavings": tosavings == null ? null : tosavings,
  };
}

class Cartlist {
  Cartlist({
    this.cartid,
    this.productid,
    this.userid,
    this.quantity,
    this.ondate,
    this.price,
    this.totprice,
    this.productname,
    this.baseprice,
    this.imgurl,
    this.unit,
    this.totamount,
    this.discount,
    this.mrp,
  });

  String? cartid;
  String? productid;
  String? userid;
  String? quantity;
  dynamic ondate;
  String? price;
  String? totprice;
  String? productname;
  String? baseprice;
  String? imgurl;
  String? unit;
  double? totamount;
  String? discount;
  String? mrp;

  factory Cartlist.fromJson(Map<String, dynamic> json) => Cartlist(
    cartid: json["cartid"] == null ? null : json["cartid"],
    productid: json["productid"] == null ? null : json["productid"],
    userid: json["userid"] == null ? null : json["userid"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    ondate: json["ondate"],
    price: json["price"] == null ? null : json["price"],
    totprice: json["totprice"] == null ? null : json["totprice"],
    productname: json["productname"] == null ? null : json["productname"],
    baseprice: json["baseprice"] == null ? null : json["baseprice"],
    imgurl: json["imgurl"] == null ? null : json["imgurl"],
    unit: json["unit"] == null ? null : json["unit"],
    totamount: json["totamount"] == null ? null : json["totamount"],
    discount: json["discount"] == null ? null : json["discount"],
    mrp: json["mrp"] == null ? null : json["mrp"],
  );

  Map<String, dynamic> toJson() => {
    "cartid": cartid == null ? null : cartid,
    "productid": productid == null ? null : productid,
    "userid": userid == null ? null : userid,
    "quantity": quantity == null ? null : quantity,
    "ondate": ondate,
    "price": price == null ? null : price,
    "totprice": totprice == null ? null : totprice,
    "productname": productname == null ? null : productname,
    "baseprice": baseprice == null ? null : baseprice,
    "imgurl": imgurl == null ? null : imgurl,
    "unit": unit == null ? null : unit,
    "totamount": totamount == null ? null : totamount,
    "discount": discount == null ? null : discount,
    "mrp": mrp == null ? null : mrp,
  };
}
