import 'package:chuva_dart/src/models/calendar_list_model.dart';
import 'package:chuva_dart/src/utils.dart';
import 'package:chuva_dart/src/widgets/card_calendar.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

class DetailPeopleView extends StatelessWidget {
  final Person detailPeople;
  final ValueNotifier<List<Datum>> data;
  const DetailPeopleView(
      {super.key, required this.detailPeople, required this.data});

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, top: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    backgroundImage: detailPeople.picture != null
                        ? NetworkImage(detailPeople.picture!)
                        : null,
                    child: detailPeople.picture == null
                        ? const Icon(Icons.person,
                            size: 40, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          detailPeople.name,
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              height: 1.25),
                        ),
                      ),
                      Text(
                        detailPeople.institution ?? "",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  )
                ],
              ),
            ),
            if (detailPeople.bio.ptBr != null)
              Container(
                  margin: const EdgeInsets.only(left: 15, top: 25, bottom: 10),
                  child: const Text(
                    "Bio",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  )),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 20),
              child: Text(
                Utils.FormatterDescription(detailPeople.bio.ptBr ?? ""),
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 15, top: 25, bottom: 5),
                child: const Text(
                  "Atividades",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                )),
            Container(
              margin: const EdgeInsets.only(left: 25, bottom: 5),
              child: const Text("dom., 26/11/2023",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: ValueListenableBuilder<List<Datum>>(
                valueListenable: data,
                builder: (context, dataList, _) {
                  // Filtrando os itens do data que contêm a pessoa com o ID específico
                  final activitiesForPerson = dataList
                      .where((datum) => datum.people
                          .any((person) => person.id == detailPeople.id))
                      .toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: activitiesForPerson.length,
                    itemBuilder: (cxt, i) {
                      final item = activitiesForPerson[i];

                      return CalendarCard(item: item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
