// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  String type;
  // String job;
  // String id;
  // DateTime createdAt;
  String contact;
  String email;
  String line1;
  String zipcode;
  String city;
  String state;
  String country;
  String line2;
  String email_notify;
  String zipcodes;
  String citys;
  String states;
  String countrys;
  String names;
  String amount;
  String currency;

  UserModel({
    this.name,
    this.type,
    // this.job,
    // this.id,
    // this.createdAt,
    this.contact,
    this.email,
    this.line1,
    this.zipcode,
    this.city,
    this.state,
    this.country,
    this.line2,
    this.email_notify,
    this.zipcodes,
    this.citys,
    this.states,
    this.countrys,
    this.names,
    this.amount,
    this.currency,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    // name: json["name"],
    // job: json["job"],
    // id: json["id"],
    // createdAt: DateTime.parse(json["createdAt"]),
    type: json["type"],
    name: json["customer_details"]["customer_name"],
    contact: json["9999999999"],
    email: json["publicemail545@gmail.com"],
    line1: json["Ground & 1st Floor, SJR Cyber Laskar"],
    zipcode: json["560068"],
    city: json["Bengaluru"],
    state: json["Karnataka"],
    country: json["in"],
    line2: json["Ground & 1st Floor, SJR Cyber Laskar"],
    zipcodes: json["560068"],
    citys: json["Bengaluru"],
    states: json["Karnataka"],
    countrys: json["in"],
    names: json["Master Cloud Computing in 30 Days"],
    amount: json[399],
    currency: json["INR"],
    email_notify: json["1"],
  );

  Map<String, dynamic> toJson() => {
    // "name": name,
    // "job": job,
    // "id": id,s
    // "createdAt": createdAt.toIso8601String(),
    type: type,
    name: name,
    contact: "9999999999",
    email: "publicemail545@gmail.com",
    line1: "Ground & 1st Floor, SJR Cyber Laskar",
    zipcode: "560068",
    city: "Bengaluru",
    state: "Karnataka",
    country: "in",
    line2: "Ground & 1st Floor, SJR Cyber Laskar",
    zipcodes: "560068",
    citys: "Bengaluru",
    states: "Karnataka",
    countrys: "in",
    names: "Master Cloud Computing in 30 Days",
    amount: 399,
    currency: "INR",
    email_notify: 1,
  };
}
