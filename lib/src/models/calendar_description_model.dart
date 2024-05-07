class CalendarDescriptionModel {
  String ptBr;

  CalendarDescriptionModel({
    required this.ptBr,
  });

  factory CalendarDescriptionModel.fromJson(Map<String, dynamic> json) =>
      CalendarDescriptionModel(
        ptBr: json["pt-br"],
      );

  Map<String, dynamic> toJson() => {
        "pt-br": ptBr,
      };
}
