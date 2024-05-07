import 'calendar_description_model.dart';

class CalendarCategoryModel {
  int id;
  CalendarDescriptionModel title;
  String color;
  String backgroundColor;

  CalendarCategoryModel({
    required this.id,
    required this.title,
    required this.color,
    required this.backgroundColor,
  });

  factory CalendarCategoryModel.fromJson(Map<String, dynamic> json) =>
      CalendarCategoryModel(
        id: json["id"],
        title: CalendarDescriptionModel.fromJson(json["title"]),
        color: json["color"],
        backgroundColor: json["background-color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
        "color": color,
        "background-color": backgroundColor,
      };
}
