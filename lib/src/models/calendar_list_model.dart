import 'dart:convert';

import 'package:chuva_dart/src/models/calendar_description_model.dart';

import 'calendar_category_model.dart';
import 'calendar_location_model.dart';
import 'calendar_person_model.dart';

CalendarListModel endereCarcacasModelFromJson(String str) =>
    CalendarListModel.fromJson(json.decode(str));

String endereCarcacasModelToJson(CalendarListModel data) =>
    json.encode(data.toJson());

class CalendarListModel {
  int id;
  int changed;
  DateTime start;
  DateTime end;
  CalendarDescriptionModel title;
  CalendarDescriptionModel description;
  CalendarCategoryModel category;
  List<CalendarLocationModel> locations;
  CalendarCategoryModel type;
  List<dynamic> papers;
  List<CalendarPersonModel> people;
  int status;
  int weight;
  dynamic addons;
  dynamic parent;
  String event;

  CalendarListModel({
    required this.id,
    required this.changed,
    required this.start,
    required this.end,
    required this.title,
    required this.description,
    required this.category,
    required this.locations,
    required this.type,
    required this.papers,
    required this.people,
    required this.status,
    required this.weight,
    required this.addons,
    required this.parent,
    required this.event,
  });
  factory CalendarListModel.fromJson(Map<String, dynamic> json) =>
      CalendarListModel(
        id: json["id"],
        changed: json["changed"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        title: CalendarDescriptionModel.fromJson(json["title"]),
        description: CalendarDescriptionModel.fromJson(json["description"]),
        category: CalendarCategoryModel.fromJson(json["category"]),
        locations: List<CalendarLocationModel>.from(
            json["locations"].map((x) => CalendarLocationModel.fromJson(x))),
        type: CalendarCategoryModel.fromJson(json["type"]),
        papers: List<dynamic>.from(json["papers"].map((x) => x)),
        people: List<CalendarPersonModel>.from(
            json["people"].map((x) => CalendarPersonModel.fromJson(x))),
        status: json["status"],
        weight: json["weight"],
        addons: json["addons"],
        parent: json["parent"],
        event: json["event"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "changed": changed,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "title": title.toJson(),
        "description": description.toJson(),
        "category": category.toJson(),
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
        "type": type.toJson(),
        "papers": List<dynamic>.from(papers.map((x) => x)),
        "people": List<dynamic>.from(people.map((x) => x.toJson())),
        "status": status,
        "weight": weight,
        "addons": addons,
        "parent": parent,
        "event": event,
      };
}
