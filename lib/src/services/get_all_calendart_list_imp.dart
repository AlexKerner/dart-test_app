import 'dart:convert';

import 'package:chuva_dart/src/models/calendar_list_model.dart';
import 'package:chuva_dart/src/services/i_get_all_calendar_list.dart';
import 'package:dio/dio.dart';

// ignore: constant_identifier_names
const BASEURL =
    "https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json";

class GetAllCalendartListImp implements IGetAllCalendarList {
  final Dio _dio;

  GetAllCalendartListImp(this._dio);
  @override
  Future<List<Datum>> getAllCalendarList() async {
    try {
      final response = await _dio.get(BASEURL,
          options: Options(contentType: "application/json"));

      final dataFinal = jsonDecode(response.data);
      final calendarModel = CalendarListModel.fromJson((dataFinal));

      final listaModel = calendarModel.data;

      return listaModel;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
