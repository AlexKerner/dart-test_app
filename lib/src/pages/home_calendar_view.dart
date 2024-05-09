import 'package:chuva_dart/src/controllers/calendar_home_controller.dart';
import 'package:chuva_dart/src/services/get_all_calendart_list_imp.dart';
import 'package:chuva_dart/src/widgets/app_bar.dart';
import 'package:chuva_dart/src/widgets/card_calendar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final RouteObserver<ModalRoute<Object?>> routeObserver =
    RouteObserver<ModalRoute<Object?>>();

class HomeCalendarView extends StatefulWidget {
  const HomeCalendarView({Key? key}) : super(key: key);

  @override
  State<HomeCalendarView> createState() => _HomeCalendarViewState();
}

class _HomeCalendarViewState extends State<HomeCalendarView> with RouteAware {
  final calendarController =
      CalendarHomeController(GetAllCalendartListImp(Dio()));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    calendarController.getAllCalendar();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Atualiza a lista ao voltar da pagina de detalhe
    calendarController.getAllCalendar();
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
