import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/details/controller/details_controller.dart';
import 'package:carlanda_car_buy_sell/features/details/presentation/components/delivery_option_dialog.dart';
import 'package:carlanda_car_buy_sell/features/details/presentation/components/details_page_top_section.dart';
import 'package:carlanda_car_buy_sell/features/details/presentation/components/details_section.dart';
import 'package:carlanda_car_buy_sell/features/details/presentation/components/key_specification_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends GetView<DetailsController> {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Car Details"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Obx(() {
          if (controller.carDetails.value == null) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          final car = controller.carDetails.value!;
          return SingleChildScrollView(
            child: Column(
              children: [
                20.heightSpace(),
                DetailsPageTopSection(car: car),
                20.heightSpace(),
                KeySpecificationSection(),
                12.heightSpace(),
                DetailsSection(),
                24.heightSpace(),
                CustomSubmitButton(
                  text: "Buy Now",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => DeliveryOptionDialog(),
                    );
                  },
                ),
                40.heightSpace(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
