import 'package:carlanda_car_buy_sell/core/common/widgets/custom_textformfield.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/search/presentation/components/filter_bottom_sheet_widget.dart';
import 'package:carlanda_car_buy_sell/features/view_cars/controller/view_cars_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

class CarSearchBar extends StatelessWidget {
  CarSearchBar({super.key});
  final ViewCarsController controller = Get.find<ViewCarsController>();
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller.search,
      hintText: "Search",
      prefixIconPath: IconPath.search,
      suffixIconPath: IconPath.filter,
      onSuffixIconTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: "#E8E8E9".toColor(),
          builder: (_) => FilterBottomSheetWidget(),
        );
      },
    );
  }
}
