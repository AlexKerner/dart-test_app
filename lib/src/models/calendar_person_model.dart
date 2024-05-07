import 'package:chuva_dart/src/models/calendar_description_model.dart';

import 'calendar_role_model.dart';

class CalendarPersonModel {
  int id;
  String title;
  String name;
  String institution;
  CalendarDescriptionModel bio;
  String picture;
  int weight;
  CalendarRoleModel role;
  String hash;

  CalendarPersonModel({
    required this.id,
    required this.title,
    required this.name,
    required this.institution,
    required this.bio,
    required this.picture,
    required this.weight,
    required this.role,
    required this.hash,
  });

  factory CalendarPersonModel.fromJson(Map<String, dynamic> json) =>
      CalendarPersonModel(
        id: json["id"],
        title: json["title"],
        name: json["name"],
        institution: json["institution"],
        bio: CalendarDescriptionModel.fromJson(json["bio"]),
        picture: json["picture"],
        weight: json["weight"],
        role: CalendarRoleModel.fromJson(json["role"]),
        hash: json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "name": name,
        "institution": institution,
        "bio": bio.toJson(),
        "picture": picture,
        "weight": weight,
        "role": role.toJson(),
        "hash": hash,
      };
}
