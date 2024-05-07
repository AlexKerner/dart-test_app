import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

class DetailCalendar extends StatelessWidget {
  const DetailCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Chuva 💜 Flutter',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5)),
        centerTitle: true,
        backgroundColor: fromCssColor("#456189"),
      ),
      body: Container(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          color: fromCssColor("#238fdd"),
          padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
          child: Text(
            "Categoria",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
