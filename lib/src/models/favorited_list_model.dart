import 'package:chuva_dart/src/models/calendar_list_model.dart';

class FavoritedDatum {
  final Datum datum;
  bool isFavorited;

  FavoritedDatum({required this.datum, this.isFavorited = false});

    void toggleFavorite() {
    isFavorited = !isFavorited;
  }
}
