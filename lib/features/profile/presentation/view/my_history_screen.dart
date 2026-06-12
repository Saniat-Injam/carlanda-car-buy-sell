import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/components/history_list_section.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/components/my_history_tabs.dart';
import 'package:flutter/material.dart';

class MyHistoryScreen extends StatelessWidget {
  const MyHistoryScreen({super.key});
  static const String routeName = '/profile/my-history';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "My History"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          children: [
            16.heightSpace(),
            MyHistoryTabs(),
            20.heightSpace(),
            Expanded(child: HistoryListSection()),
          ],
        ),
      ),
    );
  }
}
