import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/track_car/presentation/components/status_section.dart';
import 'package:flutter/material.dart';

class ViewProgressScreen extends StatelessWidget {
  const ViewProgressScreen({super.key});
  static const String routeName = '/track-car/show-progress';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Track Your Car"),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightSpace(),
            CustomText(text: "Delivery to Port ", fontSize: 16.sp),
            16.heightSpace(),
            Expanded(child: StatusSection()),
          ],
        ),
      ),
    );
  }
}
