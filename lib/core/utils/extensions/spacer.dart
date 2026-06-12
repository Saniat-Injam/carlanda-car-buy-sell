import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:flutter/widgets.dart';

extension SpacerExtension on num {
  SizedBox heightSpace() => SizedBox(height: toDouble().sp);
  SizedBox widthSpace() => SizedBox(width: toDouble().sp);
}
