// To parse this JSON data, do
//
//     final company = companyFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Company {
  Company({
    required this.id,
    required this.username,
    required this.password,
    required this.profileImage,
    required this.coverImage,
    required this.title,
  });

  int id;
  String username;
  String password;
  dynamic profileImage;
  dynamic coverImage;
  String title;

  factory Company.fromJson(String str) => Company.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Company.fromMap(Map<String, dynamic> json) => Company(
    id: json["id"],
    username: json["username"],
    password: json["password"],
    profileImage: json["profile_image"],
    coverImage: json["cover_image"],
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "password": password,
    "profile_image": profileImage,
    "cover_image": coverImage,
    "title": title,
  };
}
