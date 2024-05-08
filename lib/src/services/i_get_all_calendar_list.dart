
import 'package:chuva_dart/src/models/calendar_list_model.dart';

abstract interface class IGetAllCalendarList {
  Future<List<Datum>> getAllCalendarList();
}
