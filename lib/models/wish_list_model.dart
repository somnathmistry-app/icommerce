// To parse this JSON data, do
//
//     final wishListModel = wishListModelFromJson(jsonString);

import 'dart:convert';

WishListModel wishListModelFromJson(String str) => WishListModel.fromJson(json.decode(str));

String wishListModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
  WishListModel({
    this.status,
    this.wishlist,
  });

  String? status;
  List<Wishlist>? wishlist;

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
    status: json["status"] == null ? null : json["status"],
    wishlist: json["wishlist"] == null ? null : List<Wishlist>.from(json["wishlist"].map((x) => Wishlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "wishlist": wishlist == null ? null : List<dynamic>.from(wishlist!.map((x) => x.toJson())),
  };
}

class Wishlist {
  Wishlist({
    this.srno,
    this.userid,
    this.productid,
    this.ondate,
    this.wishlistid,
    this.productname,
    this.imgurl,
    this.price,
    this.unit,
    this.qty,
    this.discount,
    this.baseprice,
  });

  dynamic srno;
  String? userid;
  String? productid;
  dynamic ondate;
  String? wishlistid;
  String? productname;
  String? imgurl;
  String? price;
  String? unit;
  String? qty;
  String? discount;
  String? baseprice;

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
    srno: json["srno"],
    userid: json["userid"] == null ? null : json["userid"],
    productid: json["productid"] == null ? null : json["productid"],
    ondate: json["ondate"],
    wishlistid: json["wishlistid"] == null ? null : json["wishlistid"],
    productname: json["productname"] == null ? null : json["productname"],
    imgurl: json["imgurl"] == null ? null : json["imgurl"],
    price: json["price"] == null ? null : json["price"],
    unit: json["unit"] == null ? null : json["unit"],
    qty: json["qty"] == null ? null : json["qty"],
    discount: json["discount"] == null ? null : json["discount"],
    baseprice: json["baseprice"] == null ? null : json["baseprice"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno,
    "userid": userid == null ? null : userid,
    "productid": productid == null ? null : productid,
    "ondate": ondate,
    "wishlistid": wishlistid == null ? null : wishlistid,
    "productname": productname == null ? null : productname,
    "imgurl": imgurl == null ? null : imgurl,
    "price": price == null ? null : price,
    "unit": unit == null ? null : unit,
    "qty": qty == null ? null : qty,
    "discount": discount == null ? null : discount,
    "baseprice": baseprice == null ? null : baseprice,
  };
}
