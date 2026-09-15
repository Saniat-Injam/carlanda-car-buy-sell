import 'package:carlanda_car_buy_sell/core/common/entity/car_entity.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

import '../../../details/presentation/view/payment_screen.dart';

class CommonBookingCarsCard extends StatelessWidget {
  const CommonBookingCarsCard({super.key, required this.car});

  final CarEntity car;

  @override
  Widget build(BuildContext context) {
    final bool isPaid = car.isPaid;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Image
          Container(
            height: context.height * 0.22,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
              image: DecorationImage(
                image: AssetImage(car.imagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),

          10.heightSpace(),

          // Title + Status badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.6,
                child: CustomText(
                  text: car.title,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: "#151B27".toColor(),
                ),
              ),
              // const Spacer(),
              // _StatusBadge(isPaid: isPaid),
            ],
          ),

          10.heightSpace(),

          // Year & Mileage
          Row(
            children: [
              CustomText(
                text: "Year: ",
                color: "#444952".toColor(),
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              CustomText(
                text: car.year,
                color: "#444952".toColor(),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
              24.widthSpace(),
              CustomText(
                text: "Mileage: ",
                color: "#444952".toColor(),
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              CustomText(
                text: "${car.mileage} Km",
                color: "#444952".toColor(),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ],
          ),

          10.heightSpace(),

          Row(
            children: [
              CustomText(
                text: "Tracking ID: ",
                color: "#444952".toColor(),
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              CustomText(
                text: car.id,
                color: "#444952".toColor(),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
              24.widthSpace(),
            ],
          ),

          10.heightSpace(),
          // Date
          Row(
            children: [
              CustomText(
                text: "Date: ",
                color: "#444952".toColor(),
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              CustomText(
                text: "12 Aug, 2024",
                color: "#444952".toColor(),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
              24.widthSpace(),
            ],
          ),
          10.heightSpace(),
          // Optional price line (only show when Unpaid)
          Row(
            children: [
              CustomText(
                text: "Price: ",
                color: "#444952".toColor(),
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              CustomText(
                text: "\$${car.price}",
                color: "#CF0607".toColor(),
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Divider(color: "#EDEDED".toColor()),
          ),

          // Action button: Pay Now (unpaid) or Paid (disabled)
          CustomSubmitButton(
            text: "Pay Now",
            onTap: () => Get.to(() => PaymentScreen()),
          ),
        ],
      ),
    );
  }

  InkWell _buildButton({
    required String iconPath,
    required String title,
    required Function() onTap,
  }) => InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: "#B6B8BC".toColor()),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath),
          if (title.isNotEmpty) ...[
            10.widthSpace(),
            CustomText(
              text: title,
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
              color: "#000000".toColor(),
            ),
          ],
        ],
      ),
    ),
  );
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.isPaid});

  final bool isPaid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: (isPaid ? "#E6F6EA" : "#FDECEC").toColor(),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: (isPaid ? "#22A45D" : "#CF0607").toColor()),
      ),
      child: CustomText(
        text: isPaid ? "Paid" : "Unpaid",
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: (isPaid ? "#22A45D" : "#CF0607").toColor(),
      ),
    );
  }
}
