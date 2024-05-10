import 'package:chuva_dart/src/controllers/calendar_home_controller.dart';
import 'package:chuva_dart/src/models/calendar_list_model.dart';
import 'package:chuva_dart/src/services/get_all_calendart_list_imp.dart';
import 'package:chuva_dart/src/widgets/app_bar.dart';
import 'package:chuva_dart/src/widgets/card_calendar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

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

  late List<List<Datum>> eventsGroupedByDay;
  int selectedIndex = -1;

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
    // Atualiza a lista ao voltar da página de detalhe
    calendarController.getAllCalendar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: ValueListenableBuilder(
        valueListenable: calendarController.listByDay,
        builder: (context, listByDay, _) {
          return ValueListenableBuilder(
            valueListenable: calendarController.listFiltered,
            builder: (context, valor, _) {
              if (calendarController.listaGetCalendar.value.isEmpty) {
                calendarController.listaGetCalendar.value =
                    valor; // Atualiza a lista original
              }
              // Agrupa os eventos pelo dia
              eventsGroupedByDay = groupEventsByDay(listByDay);

              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: fromCssColor("#306DC3")),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 55,
                          padding: const EdgeInsets.only(top: 3),
                          color: Colors.white,
                          child: const Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Nov",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      height: 1),
                                ),
                                Text("2023",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: eventsGroupedByDay.length,
                            itemBuilder: (cxt, i) {
                              final dayEvents = eventsGroupedByDay[i];
                              final item = dayEvents.first;
                              return SizedBox(
                                width: 60,
                                height: 200,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = i;
                                    });
                                    calendarController.getByDay(item.start);
                                  },
                                  child: Center(
                                    child: Text(
                                      item.start.day.toString(),
                                      style: TextStyle(
                                        color: selectedIndex == i
                                            ? Colors.white
                                            : fromCssColor("#90AEDA"),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: valor.length,
                      itemBuilder: (cxt, i) {
                        final item = valor[i];
                        return CalendarCard(item: item);
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  // Função para agrupar eventos pelo dia
  List<List<Datum>> groupEventsByDay(List<Datum> events) {
    Map<int, List<Datum>> groupedEvents = {};
    for (var event in events) {
      int day = event.start.day;
      groupedEvents.putIfAbsent(day, () => []);
      groupedEvents[day]!.add(event);
    }
    return groupedEvents.values.toList();
  }
}
