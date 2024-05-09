import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(140);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 140,
      centerTitle: true,
      title: Column(
        children: [
          const Text(
            'Chuva 💜 Flutter',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5),
          ),
          const Text(
            "Programação",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
          ),
          Container(
            width: 350,
            height: 50,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Row(
              children: [
                // Espaçamento entre a borda esquerda e o ícone
                Container(
                  width: 60,
                  height: 50,
                  margin: const EdgeInsets.only(left: 4, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: fromCssColor("#306DC3"),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.calendar_month,
                    size: 30,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Exibindo todas as atividades',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: fromCssColor("#456189"),
    );
  }
}
