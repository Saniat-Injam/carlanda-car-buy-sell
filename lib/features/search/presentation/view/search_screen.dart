import 'package:carlanda_car_buy_sell/core/common/widgets/common_car_card.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/search/controller/search_screen_controller.dart';
import 'package:carlanda_car_buy_sell/features/search/presentation/components/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  static const String routeName = '/search-car';
  final SearchScreenController controller = Get.find<SearchScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SearchBarWidget(),
              Obx(
                () => controller.isSearching.isTrue
                    ? Expanded(
                        child: Column(
                          children: [
                            10.heightSpace(),
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) => CommonCarCard(
                                  car: controller.searchResult[index],
                                 
                                ),
                                separatorBuilder: (context, index) =>
                                    16.heightSpace(),
                                itemCount: controller.searchResult.length,
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
