import 'package:chuva_dart/src/models/calendar_description_model.dart';

class CalendarTypeModel {
  int id;
  CalendarDescriptionModel title;

  CalendarTypeModel({
    required this.id,
    required this.title,
  });

  factory CalendarTypeModel.fromJson(Map<String, dynamic> json) =>
      CalendarTypeModel(
        id: json["id"],
        title: CalendarDescriptionModel.fromJson(json["title"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
      };
}
