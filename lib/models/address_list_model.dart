// To parse this JSON data, do
//
//     final addressListModel = addressListModelFromJson(jsonString);

import 'dart:convert';

AddressListModel addressListModelFromJson(String str) => AddressListModel.fromJson(json.decode(str));

String addressListModelToJson(AddressListModel data) => json.encode(data.toJson());

class AddressListModel {
  AddressListModel({
    this.status,
    this.addresslist,
  });

  String? status;
  List<Addresslist>? addresslist;

  factory AddressListModel.fromJson(Map<String, dynamic> json) => AddressListModel(
    status: json["status"] == null ? null : json["status"],
    addresslist: json["addresslist"] == null ? null : List<Addresslist>.from(json["addresslist"].map((x) => Addresslist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "addresslist": addresslist == null ? null : List<dynamic>.from(addresslist!.map((x) => x.toJson())),
  };
}

class Addresslist {
  Addresslist({
    this.srno,
    this.userid,
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
    this.states
  });

  String? srno;
  String? userid;
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

  factory Addresslist.fromJson(Map<String, dynamic> json) => Addresslist(
    srno: json["srno"] == null ? null : json["srno"],
    userid: json["userid"] == null ? null : json["userid"],
    addrtype: json["addrtype"] == null ? null : json["addrtype"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phno1: json["phno1"] == null ? null : json["phno1"],
    phno2: json["phno2"] == null ? null : json["phno2"],
    addrs: json["addrs"] == null ? null : json["addrs"],
    landmark: json["landmark"] == null ? null : json["landmark"],
    pin: json["pin"] == null ? null : json["pin"],
    city: json["city"] == null ? null : json["city"],
    states: json["states"] == null ? null : json["states"],
    isActive: json["IsActive"],
    deliverytype: json["deliverytype"],
  );

  Map<String, dynamic> toJson() => {
    "srno": srno == null ? null : srno,
    "userid": userid == null ? null : userid,
    "addrtype": addrtype == null ? null : addrtype,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phno1": phno1 == null ? null : phno1,
    "phno2": phno2 == null ? null : phno2,
    "addrs": addrs == null ? null : addrs,
    "landmark": landmark == null ? null : landmark,
    "pin": pin == null ? null : pin,
    "city": city == null ? null : city,
    "states": states == null ? null : states,
    "IsActive": isActive,
    "deliverytype": deliverytype,
  };
}
