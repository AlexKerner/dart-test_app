import 'package:chuva_dart/src/controllers/calendar_home_controller.dart';
import 'package:chuva_dart/src/services/get_all_calendart_list_imp.dart';
import 'package:chuva_dart/src/widgets/app_bar.dart';
import 'package:chuva_dart/src/widgets/card_calendar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeCalendarView extends StatefulWidget {
  const HomeCalendarView({super.key});

  @override
  State<HomeCalendarView> createState() => _HomeCalendarViewState();
}

class _HomeCalendarViewState extends State<HomeCalendarView> {
  final calendarController =
      CalendarHomeController(GetAllCalendartListImp(Dio()));

  @override
  void initState() {
    calendarController.getAllCalendar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: ValueListenableBuilder(
          valueListenable: calendarController.listaGetCalendar,
          builder: (context, valor, _) {
            return ListView.builder(
              itemCount: valor.length,
              itemBuilder: (cxt, i) {
                final item = valor[i];

                return CalendarCard(item: item);
              },
            );
          }),
    );
  }
}
