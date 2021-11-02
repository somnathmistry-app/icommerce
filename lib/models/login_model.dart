// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.fname,
    this.lname,
    this.email,
    this.phoneno,
    this.userid,
    this.profilepic,
    this.dob,
  });

  String? status;
  String? fname;
  String? lname;
  String? email;
  String? phoneno;
  String? userid;
  String? profilepic;
  String? dob;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"] == null ? null : json["status"],
    fname: json["fname"] == null ? null : json["fname"],
    lname: json["lname"] == null ? null : json["lname"],
    email: json["email"] == null ? null : json["email"],
    phoneno: json["phoneno"] == null ? null : json["phoneno"],
    userid: json["userid"] == null ? null : json["userid"],
    profilepic: json["profilepic"] == null ? null : json["profilepic"],
    dob: json["dob"] == null ? null : json["dob"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "fname": fname == null ? null : fname,
    "lname": lname == null ? null : lname,
    "email": email == null ? null : email,
    "phoneno": phoneno == null ? null : phoneno,
    "userid": userid == null ? null : userid,
    "profilepic": profilepic == null ? null : profilepic,
    "dob": dob == null ? null : dob,
  };
}
