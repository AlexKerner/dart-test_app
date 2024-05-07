// To parse this JSON data, do
//
//     final calendarListModelTeste = calendarListModelTesteFromJson(jsonString);

import 'dart:convert';

CalendarListModelTeste calendarListModelTesteFromJson(String str) =>
    CalendarListModelTeste.fromJson(json.decode(str));

String calendarListModelTesteToJson(CalendarListModelTeste data) =>
    json.encode(data.toJson());

class CalendarListModelTeste {
  final int count;
  final Links links;
  final List<Datum> data;

  CalendarListModelTeste({
    required this.count,
    required this.links,
    required this.data,
  });

  factory CalendarListModelTeste.fromJson(Map<String, dynamic> json) =>
      CalendarListModelTeste(
        count: json["count"],
        links: Links.fromJson(json["links"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "links": links.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final int changed;
  final DateTime start;
  final DateTime end;
  final Description title;
  final Description description;
  final Category category;
  final List<Location> locations;
  final Type type;
  final List<dynamic> papers;
  final List<Person> people;
  final int status;
  final int weight;
  final dynamic addons;
  final int? parent;
  final Event event;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        changed: json["changed"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        title: Description.fromJson(json["title"]),
        description: Description.fromJson(json["description"]),
        category: Category.fromJson(json["category"]),
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
        type: Type.fromJson(json["type"]),
        papers: List<dynamic>.from(json["papers"].map((x) => x)),
        people:
            List<Person>.from(json["people"].map((x) => Person.fromJson(x))),
        status: json["status"],
        weight: json["weight"],
        addons: json["addons"],
        parent: json["parent"],
        event: eventValues.map[json["event"]]!,
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
        "event": eventValues.reverse[event],
      };
}

class Category {
  final int id;
  final Description title;
  final String? color;
  final String? backgroundColor;

  Category({
    required this.id,
    required this.title,
    required this.color,
    required this.backgroundColor,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: Description.fromJson(json["title"]),
        color: json["color"],
        backgroundColor: json["background-color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
        "color": color,
        "background-color": backgroundColorValues.reverse[backgroundColor],
      };
}

enum BackgroundColor { E4_FFFE, F5_F3_E5, F7_F0_FB, FEEFE4, FEFCE7 }

final backgroundColorValues = EnumValues({
  "#E4FFFE": BackgroundColor.E4_FFFE,
  "#F5F3E5": BackgroundColor.F5_F3_E5,
  "#F7F0FB": BackgroundColor.F7_F0_FB,
  "#FEEFE4": BackgroundColor.FEEFE4,
  "#FEFCE7": BackgroundColor.FEFCE7
});

enum Color { C24_FFE, C7_B884, F0_DB06, FB8_C2_C, THE_29_CFC9 }

final colorValues = EnumValues({
  "#C24FFE": Color.C24_FFE,
  "#C7B884": Color.C7_B884,
  "#F0DB06": Color.F0_DB06,
  "#FB8C2C": Color.FB8_C2_C,
  "#29CFC9": Color.THE_29_CFC9
});

class Description {
  final String? ptBr;

  Description({
    required this.ptBr,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        ptBr: json["pt-br"],
      );

  Map<String, dynamic> toJson() => {
        "pt-br": ptBr,
      };
}

enum Event { TESTE_EXERCICIO }

final eventValues = EnumValues({"teste-exercicio": Event.TESTE_EXERCICIO});

class Location {
  final int id;
  final Description title;
  final int parent;
  final dynamic map;

  Location({
    required this.id,
    required this.title,
    required this.parent,
    required this.map,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        title: Description.fromJson(json["title"]),
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

class Person {
  final int id;
  final String? title;
  final String name;
  final String? institution;
  final Description bio;
  final String? picture;
  final int weight;
  final Role role;
  final String hash;

  Person({
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

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        title: json["title"],
        name: json["name"],
        institution: json["institution"],
        bio: Description.fromJson(json["bio"]),
        picture: json["picture"],
        weight: json["weight"],
        role: Role.fromJson(json["role"]),
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

class Role {
  final int id;
  final Description label;

  Role({
    required this.id,
    required this.label,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        label: Description.fromJson(json["label"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label.toJson(),
      };
}

class Type {
  final int id;
  final Description title;

  Type({
    required this.id,
    required this.title,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        title: Description.fromJson(json["title"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
      };
}

class Links {
  final String self;
  final String next;

  Links({
    required this.self,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "next": next,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
