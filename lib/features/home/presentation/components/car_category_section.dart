import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/will_d_pictures.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';

class CarCategorySection extends StatelessWidget {
  CarCategorySection({super.key});
  final List<String> categoryImages = [
    WillDPictures.car1,
    WillDPictures.car2,
    WillDPictures.car3,
    WillDPictures.car4,
    WillDPictures.car5,
  ];
  final List<String> categoryTitles = ["Sub", "Wagon", "Sedan", "EV", "Coupe"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          text: "Shop by car type",
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        ),

        10.heightSpace(),

        SizedBox(
          height: 90,
          child: ListView.separated(
            padding: EdgeInsets.all(8),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) => _buildCarCategoryWidget(
              onTap: () {},
              imagePath: categoryImages[index],
              title: categoryTitles[index],
            ),
            separatorBuilder: (context, index) => 16.widthSpace(),
            itemCount: 5,
          ),
        ),
      ],
    );
  }

  GestureDetector _buildCarCategoryWidget({
    required Function() onTap,
    required String imagePath,
    required String title,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: "#82828240".toColor().withValues(alpha: 0.25),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          8.heightSpace(),
          CustomText(text: title),
        ],
      ),
    ),
  );
}
