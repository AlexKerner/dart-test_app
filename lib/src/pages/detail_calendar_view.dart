import 'package:chuva_dart/src/controllers/calendar_home_controller.dart';
import 'package:chuva_dart/src/models/calendar_list_model.dart';
import 'package:chuva_dart/src/pages/detail_people_view.dart';
import 'package:chuva_dart/src/services/get_all_calendart_list_imp.dart';
import 'package:chuva_dart/src/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DetailCalendar extends StatefulWidget {
  final Datum detailsCalendar;

  const DetailCalendar({super.key, required this.detailsCalendar});

  @override
  State<DetailCalendar> createState() => _DetailCalendarState();
}

class _DetailCalendarState extends State<DetailCalendar> {
  final calendarController =
      CalendarHomeController(GetAllCalendartListImp(Dio()));

  bool isLoading = false;

  void showSnackBar(BuildContext context, bool isFavorited) {
    final message = isFavorited
        ? 'Vamos te lembrar dessa atividade.'
        : 'Não vamos mais te lembrar dessa atividade.';

    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    calendarController.getAllCalendar();

    initializeDateFormatting('pt_BR');

    final startDate = widget.detailsCalendar.start;
    final endDate = widget.detailsCalendar.end;
    final startFormatted = DateFormat('EEEE HH:mm', 'pt_BR').format(startDate);
    final endFormatted = DateFormat('HH:mm', 'pt_BR').format(endDate);
    final dateFormatted = '$startFormatted\h - $endFormatted\h ';

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Chuva 💜 Flutter',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5)),
        centerTitle: true,
        backgroundColor: fromCssColor("#456189"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, widget.detailsCalendar);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            color: fromCssColor(widget.detailsCalendar.category.color!),
            padding: const EdgeInsets.fromLTRB(10, 6, 0, 5),
            child: Text(
              widget.detailsCalendar.category.title.ptBr!,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              widget.detailsCalendar.title.ptBr!,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: fromCssColor("#306DC3"),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(dateFormatted,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: fromCssColor("#306DC3"),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.detailsCalendar.locations.length,
                          itemBuilder: (context, index) {
                            final item =
                                widget.detailsCalendar.locations[index];
                            return Text(item.title.ptBr!,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400));
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  widget.detailsCalendar.isFavorited =
                      !widget.detailsCalendar.isFavorited;
                  showSnackBar(context, widget.detailsCalendar.isFavorited);
                });
                // Simulação de uma operação assíncrona
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    isLoading = false;
                  });
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isLoading
                    ? fromCssColor("#DCDCDC")
                    : fromCssColor("#306DC3"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Icon(
                              widget.detailsCalendar.isFavorited
                                  ? Icons.star_outline
                                  : Icons.star,
                              color: Colors.white,
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        isLoading
                            ? "Processando"
                            : widget.detailsCalendar.isFavorited
                                ? "Remover da sua agenda"
                                : "Adicionar à sua agenda",
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 40, 15, 50),
            child: Text(
              Utils.FormatterDescription(
                  widget.detailsCalendar.description.ptBr ?? ""),
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: Set.from(widget.detailsCalendar.people
                .map((person) => person.role.label.ptBr)).length,
            itemBuilder: (cont, indx) {
              final currentCategory = Set.from(widget.detailsCalendar.people
                  .map((person) => person.role.label.ptBr)).toList()[indx];
              final peopleForCategory = widget.detailsCalendar.people
                  .where((person) => person.role.label.ptBr == currentCategory)
                  .toList();

              return Container(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentCategory!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    ...peopleForCategory
                        .map((person) => InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPeopleView(
                                      data: calendarController.listaGetCalendar,
                                      detailPeople: person,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: person.picture != null
                                          ? NetworkImage(person.picture!)
                                          : null,
                                      child: person.picture == null
                                          ? const Icon(Icons.person,
                                              size: 40, color: Colors.white)
                                          : null,
                                    ),
                                    const SizedBox(width: 18),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          person.name,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(person.institution ?? ""),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ],
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
