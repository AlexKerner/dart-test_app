import 'package:chuva_dart/src/models/calendar_list_model.dart';
import 'package:chuva_dart/src/pages/detail_calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

class CalendarCard extends StatelessWidget {
  final Datum item;

  const CalendarCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailCalendar(detailsCalendar: item),
            ),
          );
        },
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
              borderRadius: const BorderRadiusDirectional.all(
                Radius.circular(10),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.type.title.ptBr!,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      item.isFavorited
                          ? Icon(
                              Icons.bookmark,
                              color: fromCssColor("#7C90AC"),
                            )
                          : const SizedBox(
                              width: 0,
                            )
                    ],
                  ),
                  Text(
                    item.title.ptBr!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: item.people.length,
                      itemBuilder: (context, index) {
                        final person = item.people[index];
                        // Verifica se não é o último item da lista
                        final isLastItem = index == item.people.length - 1;
                        // Adiciona uma vírgula e espaçamento se não for o último item
                        final separator = isLastItem ? '' : ', ';
                        return Row(
                          children: [
                            Text(person.name),
                            Text(separator),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
