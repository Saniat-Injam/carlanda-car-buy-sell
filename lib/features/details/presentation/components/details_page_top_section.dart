import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../home/data/model/car_model.dart';

class DetailsPageTopSection extends StatelessWidget {
  final CarModel car;
  const DetailsPageTopSection({super.key, required this.car});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: context.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            image: DecorationImage(
              image: NetworkImage(
                car.carImages?.first ?? 'https://via.placeholder.com/150',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        12.heightSpace(),
        Row(
          children: [
            SizedBox(
              width: context.width * 0.6,
              child: CustomText(
                text: "${car.carName} . ${car.carModel}",
                fontSize: 20.sp,
              ),
            ),
            Expanded(
              child: CustomText(
                text: "\$${car.price}",
                color: "#CF0607".toColor(),
                fontSize: 20.sp,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        8.heightSpace(),
        Row(
          children: [
            CustomText(text: "Year: ", color: "#444952".toColor()),
            CustomText(
              text: "${car.registrationYear}",
              color: "#444952".toColor(),
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
        8.heightSpace(),
        Row(
          children: [
            SvgPicture.asset(IconPath.trackCar),
            4.widthSpace(),
            CustomText(
              text: car.carLocation ?? "Unknown Location",
              color: "#444952".toColor(),
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h),
          child: Divider(color: "#EDEDED".toColor()),
        ),
        Row(
          children: [
            Expanded(
              child: _buildButton(
                iconPath: IconPath.phone,
                title: "Call",
                onTap: () {},
              ),
            ),
            12.widthSpace(),
            Expanded(
              child: _buildButton(
                iconPath: IconPath.sms,
                title: "SMS",
                onTap: () {},
              ),
            ),
            12.widthSpace(),
            Expanded(
              child: _buildButton(
                iconPath: IconPath.whatsapp,
                title: "",
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  InkWell _buildButton({
    required String iconPath,
    required String title,
    required Function() onTap,
  }) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child:
    Container(
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
