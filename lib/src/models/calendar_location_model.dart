import 'package:chuva_dart/src/models/calendar_description_model.dart';

class CalendarLocationModel {
  int id;
  CalendarDescriptionModel title;
  int parent;
  dynamic map;

  CalendarLocationModel({
    required this.id,
    required this.title,
    required this.parent,
    required this.map,
  });

  factory CalendarLocationModel.fromJson(Map<String, dynamic> json) =>
      CalendarLocationModel(
        id: json["id"],
        title: CalendarDescriptionModel.fromJson(json["title"]),
        parent: json["parent"],
        map: json["map"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
        "parent": parent,
        "map": map,
      };
}
