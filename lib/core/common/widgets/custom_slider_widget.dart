import 'package:flutter/material.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';

enum RangeType { price, year }

class CustomRangeSlider extends StatefulWidget {
  final double min;
  final double max;
  final double initialStart;
  final double initialEnd;
  final ValueChanged<RangeValues> onChanged;
  final Color primaryColor;
  final RangeType rangeType;

  const CustomRangeSlider({
    super.key,
    required this.min,
    required this.max,
    required this.initialStart,
    required this.initialEnd,
    required this.onChanged,
    required this.primaryColor,
    required this.rangeType,
  });

  @override
  CustomRangeSliderState createState() => CustomRangeSliderState();
}

class CustomRangeSliderState extends State<CustomRangeSlider> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(widget.initialStart, widget.initialEnd);
  }

  String _formatValue(double value) {
    if (widget.rangeType == RangeType.price) {
      return "\$${value ~/ 1000}k";
    } else if (widget.rangeType == RangeType.year) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  int _calculateDivisions() {
    if (widget.rangeType == RangeType.price) {
      return ((widget.max - widget.min) ~/ 1000).toInt();
    } else if (widget.rangeType == RangeType.year) {
      return (widget.max - widget.min).toInt();
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatValue(_currentRangeValues.start),
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  _formatValue(_currentRangeValues.end),
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          10.heightSpace(),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 2.5,
              activeTrackColor: widget.primaryColor,
              inactiveTrackColor: widget.primaryColor.withValues(alpha: 0.4),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              thumbColor: widget.primaryColor,
              overlayShape: SliderComponentShape.noOverlay,
              valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: widget.primaryColor,
              showValueIndicator: ShowValueIndicator.onDrag,
            ),
            child: RangeSlider(
              min: widget.min,
              max: widget.max,
              values: _currentRangeValues,
              divisions: _calculateDivisions(),
              labels: RangeLabels(
                _formatValue(_currentRangeValues.start),
                _formatValue(_currentRangeValues.end),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
                widget.onChanged(values);
              },
            ),
          ),
        ],
      ),
    );
  }
}
