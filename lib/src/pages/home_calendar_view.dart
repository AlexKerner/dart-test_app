import 'package:chuva_dart/src/controllers/calendar_home_controller.dart';
import 'package:chuva_dart/src/pages/detail_calendar_view.dart';
import 'package:chuva_dart/src/services/get_all_calendart_list_imp.dart';
import 'package:chuva_dart/src/widgets/app_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

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
      appBar: AppBarWidget(),
      body: ValueListenableBuilder(
          valueListenable: calendarController.listaGetCalendar,
          builder: (context, valor, _) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DetailCalendar()));
              },
              child: ListView.builder(
                itemCount: valor.length,
                itemBuilder: (cxt, i) {
                  final item = valor[i];

                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Card(
                      child: Container(
                        height: 115,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white30,
                            border: Border(
                              left: BorderSide(
                                color: item.category.color != null
                                    ? fromCssColor(item.category.color!)
                                    : fromCssColor("#aaa"),
                                width: 5.0,
                              ),
                            ),
                            borderRadius: BorderRadiusDirectional.all(
                              Radius.circular(10),
                            )),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.type.title.ptBr!,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                item.title.ptBr!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              Text(item.category.title.ptBr!)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
