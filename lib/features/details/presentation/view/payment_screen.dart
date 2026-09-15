import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/enums.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/details/controller/details_controller.dart';
import 'package:carlanda_car_buy_sell/features/details/presentation/components/bank_details_section.dart';
import 'package:carlanda_car_buy_sell/features/details/presentation/components/payment_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  final DetailsController detailsController = Get.find<DetailsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Payment"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.heightSpace(),
                CustomText(text: "Payment Option", fontSize: 16.sp),
                10.heightSpace(),

                _buildButton(
                  value:
                      detailsController.selectedPaymentOption.value ==
                      PaymentOptions.express,
                  onTap: (value) => detailsController.selectPaymentOption(
                    option: PaymentOptions.express,
                  ),
                  title: "Pay with MultiCash Express",
                  icons: [],
                ),
                10.heightSpace(),
                _buildButton(
                  value:
                      detailsController.selectedPaymentOption.value ==
                      PaymentOptions.creditOrDebit,
                  onTap: (value) => detailsController.selectPaymentOption(
                    option: PaymentOptions.creditOrDebit,
                  ),
                  title: "Pay with Credit or Debit card",
                  icons: [IconPath.mastaCard, IconPath.visaCard],
                ),
                10.heightSpace(),
                _buildButton(
                  value:
                      detailsController.selectedPaymentOption.value ==
                      PaymentOptions.bankTransfer,
                  onTap: (value) => detailsController.selectPaymentOption(
                    option: PaymentOptions.bankTransfer,
                  ),
                  title: "Pay with Bank Transfer",
                  icons: [IconPath.bank],
                ),
                40.heightSpace(),
                BankDetailsSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: CustomSubmitButton(
            text: "Pay",
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => PaymentSuccessDialog(),
              );
            },
          ),
        ),
      ),
    );
  }

  InkWell _buildButton({
    required bool value,
    required Function(bool value) onTap,
    required String title,
    required List<String> icons,
  }) => InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () => onTap.call(value),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: "#FFFFFF".toColor(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.25),
            spreadRadius: 3,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Radio(
            activeColor: "#151B27".toColor(),
            value: value,
            // ignore: deprecated_member_use
            groupValue: true,
            // ignore: deprecated_member_use
            onChanged: (value) {
              onTap.call(value ?? false);
            },
          ),
          //      12.widthSpace(),
          CustomText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
          Spacer(),
          if (icons.isNotEmpty) ...[
            ...List.generate(
              icons.length,
              (index) => icons[index].contains("png")
                  ? Image.asset(icons[index], height: 25.w)
                  : SvgPicture.asset(icons[index], width: 30.w),
            ),
          ],
        ],
      ),
    ),
  );
}
