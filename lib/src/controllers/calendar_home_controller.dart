
import 'package:chuva_dart/src/models/calendar_list_model.dart';
import 'package:chuva_dart/src/services/i_get_all_calendar_list.dart';
import 'package:flutter/widgets.dart';

class CalendarHomeController {
  final IGetAllCalendarList calendarServie;

  CalendarHomeController(this.calendarServie);

  final listaGetCalendar = ValueNotifier(<Datum>[]);

  getAllCalendar() async {
    listaGetCalendar.value = await calendarServie.getAllCalendarList();
  }
}
