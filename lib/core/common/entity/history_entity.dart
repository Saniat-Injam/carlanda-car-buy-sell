import 'package:carlanda_car_buy_sell/core/utils/constants/enums.dart';

class HistoryEntity {
  final String id;
  final String title;
  final String imagePath;
  final String trackingId;
  final String date;
  final HistoryType historyType;

  HistoryEntity({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.trackingId,
    required this.date,
    required this.historyType,
  });
}
