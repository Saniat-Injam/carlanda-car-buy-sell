import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';

class GradientSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const GradientSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: value ? 1.0 : 0.0, end: value ? 1.0 : 0.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        builder: (context, t, child) {
          final bool showGradient = t > 0.01;
          return Container(
            width: 40.w,
            height: 20.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: showGradient ? null : Colors.grey.shade400,
              gradient: showGradient
                  ? LinearGradient(
                      colors: [
                        // Color.lerp(
                        //   Colors.grey.shade400,
                        //   AppColors.linearGradient.colors[0],
                        //   t,
                        // )!,
                        // Color.lerp(
                        //   Colors.grey.shade400,
                        //   AppColors.linearGradient.colors[1],
                        //   t,
                        // )!,
                        AppColors.primary,
                        AppColors.primary,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    alignment: value
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 16.w,
                      height: 16.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
