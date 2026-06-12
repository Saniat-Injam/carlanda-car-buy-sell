import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/view_cars/presentation/components/car_search_bar.dart';
import 'package:carlanda_car_buy_sell/features/view_cars/presentation/components/carl_list_view.dart';
import 'package:carlanda_car_buy_sell/features/view_cars/presentation/components/sorting_dropdown_button.dart';
import 'package:flutter/material.dart';

class ViewCarsScreen extends StatelessWidget {
  const ViewCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kToolbarHeight.heightSpace(),
          CarSearchBar(),
          10.heightSpace(),
          SortingDropdownbutton(),
          10.heightSpace(),
          CarlListView(),
        ],
      ),
    );
  }
}
