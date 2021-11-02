// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) => OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
  OrderListModel({
    this.status,
    this.orderlist,
  });

  String? status;
  List<Orderlist>? orderlist;

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
    status: json["status"] == null ? null : json["status"],
    orderlist: json["orderlist"] == null ? null : List<Orderlist>.from(json["orderlist"].map((x) => Orderlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "orderlist": orderlist == null ? null : List<dynamic>.from(orderlist!.map((x) => x.toJson())),
  };
}

class Orderlist {
  Orderlist({
    this.paydate,
    this.deliverystatus,
    this.txnid,
    this.productname,
    this.unit,
    this.prdimg,
    this.totprice,
    this.totsavings,
    this.payamount,
    this.totmrp,
    this.mrp,
    this.newprice,
    this.shippingcharge,
    this.addrtype,
    this.name,
    this.email,
    this.phno1,
    this.phno2,
    this.addrs,
    this.landmark,
    this.pin,
    this.isActive,
    this.deliverytype,
    this.city,
    this.states,
    this.srno,
    this.orderid,
    this.userid,
    this.sellerid,
    this.productid,
    this.qty,
    this.price,
    this.deliveraddressid,
    this.cartid,
    this.orderaddressid,
    this.orderdate,
    this.orderstatus,
    this.paymethod,
    this.paystatus,
    this.couponid,
  });

  String? paydate;
  String? deliverystatus;
  String? txnid;
  String? productname;
  String? unit;
  String? prdimg;
  String? totprice;
  String? totsavings;
  String? payamount;
  String? totmrp;
  String? mrp;
  String? newprice;
  String? shippingcharge;
  String? addrtype;
  String? name;
  String? email;
  String? phno1;
  String? phno2;
  String? addrs;
  String? landmark;
  String? pin;
  dynamic isActive;
  dynamic deliverytype;
  String? city;
  String? states;
  String? srno;
  String? orderid;
  String? userid;
  dynamic sellerid;
  String? productid;
  String? qty;
  String? price;
  String? deliveraddressid;
  dynamic cartid;
  dynamic orderaddressid;
  String? orderdate;
  String? orderstatus;
  String? paymethod;
  String? paystatus;
  dynamic couponid;

  factory Orderlist.fromJson(Map<String, dynamic> json) => Orderlist(
    paydate: json["paydate"] == null ? null : json["paydate"],
    deliverystatus: json["deliverystatus"] == null ? null : json["deliverystatus"],
    txnid: json["txnid"] == null ? null : json["txnid"],
    productname: json["productname"] == null ? null : json["productname"],
    unit: json["unit"] == null ? null : json["unit"],
    prdimg: json["prdimg"] == null ? null : json["prdimg"],
    totprice: json["totprice"] == null ? null : json["totprice"],
    totsavings: json["totsavings"] == null ? null : json["totsavings"],
    payamount: json["payamount"] == null ? null : json["payamount"],
    totmrp: json["totmrp"] == null ? null : json["totmrp"],
    mrp: json["mrp"] == null ? null : json["mrp"],
    newprice: json["newprice"] == null ? null : json["newprice"],
    shippingcharge: json["shippingcharge"] == null ? null : json["shippingcharge"],
    addrtype: json["addrtype"] == null ? null : json["addrtype"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phno1: json["phno1"] == null ? null : json["phno1"],
    phno2: json["phno2"] == null ? null : json["phno2"],
    addrs: json["addrs"] == null ? null : json["addrs"],
    landmark: json["landmark"] == null ? null : json["landmark"],
    pin: json["pin"] == null ? null : json["pin"],
    isActive: json["IsActive"],
    deliverytype: json["deliverytype"],
    city: json["city"] == null ? null : json["city"],
    states: json["states"] == null ? null : json["states"],
    srno: json["srno"] == null ? null : json["srno"],
    orderid: json["orderid"] == null ? null : json["orderid"],
    userid: json["userid"] == null ? null : json["userid"],
    sellerid: json["sellerid"],
    productid: json["productid"] == null ? null : json["productid"],
    qty: json["qty"] == null ? null : json["qty"],
    price: json["price"] == null ? null : json["price"],
    deliveraddressid: json["deliveraddressid"] == null ? null : json["deliveraddressid"],
    cartid: json["cartid"],
    orderaddressid: json["orderaddressid"],
    orderdate: json["orderdate"] == null ? null : json["orderdate"],
    orderstatus: json["orderstatus"] == null ? null : json["orderstatus"],
    paymethod: json["paymethod"] == null ? null : json["paymethod"],
    paystatus: json["paystatus"] == null ? null : json["paystatus"],
    couponid: json["couponid"],
  );

  Map<String, dynamic> toJson() => {
    "paydate": paydate == null ? null : paydate,
    "deliverystatus": deliverystatus == null ? null : deliverystatus,
    "txnid": txnid == null ? null : txnid,
    "productname": productname == null ? null : productname,
    "unit": unit == null ? null : unit,
    "prdimg": prdimg == null ? null : prdimg,
    "totprice": totprice == null ? null : totprice,
    "totsavings": totsavings == null ? null : totsavings,
    "payamount": payamount == null ? null : payamount,
    "totmrp": totmrp == null ? null : totmrp,
    "mrp": mrp == null ? null : mrp,
    "newprice": newprice == null ? null : newprice,
    "shippingcharge": shippingcharge == null ? null : shippingcharge,
    "addrtype": addrtype == null ? null : addrtype,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phno1": phno1 == null ? null : phno1,
    "phno2": phno2 == null ? null : phno2,
    "addrs": addrs == null ? null : addrs,
    "landmark": landmark == null ? null : landmark,
    "pin": pin == null ? null : pin,
    "IsActive": isActive,
    "deliverytype": deliverytype,
    "city": city == null ? null : city,
    "states": states == null ? null : states,
    "srno": srno == null ? null : srno,
    "orderid": orderid == null ? null : orderid,
    "userid": userid == null ? null : userid,
    "sellerid": sellerid,
    "productid": productid == null ? null : productid,
    "qty": qty == null ? null : qty,
    "price": price == null ? null : price,
    "deliveraddressid": deliveraddressid == null ? null : deliveraddressid,
    "cartid": cartid,
    "orderaddressid": orderaddressid,
    "orderdate": orderdate == null ? null : orderdate,
    "orderstatus": orderstatus == null ? null : orderstatus,
    "paymethod": paymethod == null ? null : paymethod,
    "paystatus": paystatus == null ? null : paystatus,
    "couponid": couponid,
  };
}
