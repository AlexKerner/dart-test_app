import 'package:chuva_dart/src/models/calendar_list_model.dart';
import 'package:chuva_dart/src/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DetailCalendar extends StatelessWidget {
  final Datum detailsCalendar;
  const DetailCalendar({super.key, required this.detailsCalendar});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR');
    final startDate = detailsCalendar.start;
    final endDate = detailsCalendar.end;
    final startFormatted = DateFormat('EEEE HH:mm', 'pt_BR').format(startDate);
    final endFormatted = DateFormat('HH:mm', 'pt_BR').format(endDate);
    final dateFormatted = '$startFormatted\h\ - $endFormatted\h\ ';

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
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            color: fromCssColor(detailsCalendar.category.color!),
            padding: const EdgeInsets.fromLTRB(10, 6, 0, 5),
            child: Text(
              detailsCalendar.category.title.ptBr!,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              detailsCalendar.title.ptBr!,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: fromCssColor("#306DC3"),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(dateFormatted,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400))
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: fromCssColor("#306DC3"),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: detailsCalendar.locations.length,
                          itemBuilder: (context, index) {
                            final item = detailsCalendar.locations[index];
                            return Text(item.title.ptBr!,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400));
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: fromCssColor("#306DC3"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Center(
                  child: Container(
                    width: 200,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Adicionar à sua agenda",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 40, 15, 50),
            child: Text(
              Utils.FormatterDescription(
                  detailsCalendar.description.ptBr ?? ""),
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...Set.from(detailsCalendar.people
                    .map((person) => person.role.label.ptBr)).map((roleLabel) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roleLabel!,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 10),
                      ...detailsCalendar.people
                          .where(
                              (person) => person.role.label.ptBr == roleLabel)
                          .map((person) => Container(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: person.picture != null
                                          ? NetworkImage(person.picture!)
                                          : null,
                                      child: person.picture == null
                                          ? Icon(Icons.person,
                                              size: 40, color: Colors.white)
                                          : null,
                                    ),
                                    SizedBox(width: 18),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          person.name,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(person.institution ?? ""),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                    ],
                  );
                }).toList(),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
