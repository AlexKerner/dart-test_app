import 'package:chuva_dart/src/models/calendar_list_model.dart';
import 'package:chuva_dart/src/services/i_get_all_calendar_list.dart';
import 'package:flutter/widgets.dart';

class CalendarHomeController {
  final IGetAllCalendarList calendarServie;

  CalendarHomeController(this.calendarServie);

  final listaGetCalendar = ValueNotifier(<Datum>[]);
  final listByDay = ValueNotifier(<Datum>[]);
  final listFiltered = ValueNotifier(<Datum>[]);

  getAllCalendar() async {
    listaGetCalendar.value = await calendarServie.getAllCalendarList();
    listByDay.value = List.from(listaGetCalendar.value);
    listFiltered.value = List.from(listaGetCalendar.value);
  }

  getByDay(DateTime day) async {
    final filteredEvents = listaGetCalendar.value
        .where((event) =>
            event.start.year == day.year &&
            event.start.month == day.month &&
            event.start.day == day.day)
        .toList();
    listFiltered.value = List.from(filteredEvents);
  }
}
