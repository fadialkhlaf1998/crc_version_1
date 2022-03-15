// To parse this JSON data, do
//
//     final person = personFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Person {
  Person({
    required this.id,
    required this.name,
    required this.phone,
    required this.image,
    required this.languages,
    required this.companyId,
  });

  int id;
  String name;
  String phone;
  String image;
  String languages;
  int companyId;

  factory Person.fromJson(String str) => Person.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Person.fromMap(Map<String, dynamic> json) => Person(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    image: json["image"],
    languages: json["languages"],
    companyId: json["company_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "phone": phone,
    "image": image,
    "languages": languages,
    "company_id": companyId,
  };
}
