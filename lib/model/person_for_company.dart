// To parse this JSON data, do
//
//     final personForCompany = personForCompanyFromMap(jsonString);

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class PersonForCompany {
  PersonForCompany({
    required this.id,
    required this.name,
    required this.phone,
    required this.image,
    required this.languages,
    required this.companyId,
    required this.avilable,
  }){
    if(avilable == 1){
      availableSwitch = true.obs;
    }else{
      availableSwitch = false.obs;
    }
  }

  int id;
  String name;
  String phone;
  String image;
  String languages;
  int companyId;
  int avilable;
  RxBool availableSwitch = false.obs;

  factory PersonForCompany.fromJson(String str) => PersonForCompany.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonForCompany.fromMap(Map<String, dynamic> json) => PersonForCompany(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    image: json["image"],
    languages: json["languages"],
    companyId: json["company_id"],
    avilable: json["avilable"] ,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "phone": phone,
    "image": image,
    "languages": languages,
    "company_id": companyId,
    "avilable": avilable,
  };
}
