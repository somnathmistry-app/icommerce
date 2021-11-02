// To parse this JSON data, do
//
//     final forgetpassOtpModel = forgetpassOtpModelFromJson(jsonString);

import 'dart:convert';

ForgetpassOtpModel forgetpassOtpModelFromJson(String str) => ForgetpassOtpModel.fromJson(json.decode(str));

String forgetpassOtpModelToJson(ForgetpassOtpModel data) => json.encode(data.toJson());

class ForgetpassOtpModel {
  ForgetpassOtpModel({
    this.status,
    this.otp,
    this.email,
    this.userid,
  });

  String? status;
  String? otp;
  String? email;
  String? userid;

  factory ForgetpassOtpModel.fromJson(Map<String, dynamic> json) => ForgetpassOtpModel(
    status: json["status"] == null ? null : json["status"],
    otp: json["otp"] == null ? null : json["otp"],
    email: json["email"] == null ? null : json["email"],
    userid: json["userid"] == null ? null : json["userid"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "otp": otp == null ? null : otp,
    "email": email == null ? null : email,
    "userid": userid == null ? null : userid,
  };
}
