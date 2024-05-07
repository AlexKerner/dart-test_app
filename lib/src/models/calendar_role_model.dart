import 'package:chuva_dart/src/models/calendar_description_model.dart';

class CalendarRoleModel {
  int id;
  CalendarDescriptionModel label;

  CalendarRoleModel({
    required this.id,
    required this.label,
  });

  factory CalendarRoleModel.fromJson(Map<String, dynamic> json) =>
      CalendarRoleModel(
        id: json["id"],
        label: CalendarDescriptionModel.fromJson(json["label"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label.toJson(),
      };
}
