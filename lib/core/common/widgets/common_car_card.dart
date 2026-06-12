// import 'package:carlanda_car_buy_sell/core/common/entity/car_entity.dart';
// import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
// import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
// import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
// import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
// import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
// import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
// import 'package:carlanda_car_buy_sell/features/details/presentation/view/details_screen.dart';
// import 'package:carlanda_car_buy_sell/features/home/controller/home_controller.dart';
// import 'package:carlanda_car_buy_sell/features/track_car/presentation/components/track_car_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:get/utils.dart';
//
// class CommonCarCard extends GetView<HomeController> {
//   const CommonCarCard({super.key, required this.car,});
//   final CarEntity car;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(22),
//       onTap: () => Get.to(() => DetailsScreen()),
//       child: Container(
//         padding: EdgeInsets.all(12.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(22),
//           color: Colors.white,
//         ),
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: context.height * 0.22,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(22),
//                       topRight: Radius.circular(22),
//                     ),
//                     image: DecorationImage(
//                       image: AssetImage(car.imagePath),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: SvgPicture.asset(
//                       car.isFavorite
//                           ? IconPath.favoriteFill
//                           : IconPath.favorite,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             10.heightSpace(),
//             Row(
//               children: [
//                 SizedBox(
//                   width: context.width * 0.6,
//                   child: CustomText(
//                     text: car.title,
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.w600,
//                     color: "#151B27".toColor(),
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomText(
//                     text: car.isPaid ? "Paid" : "\$${car.price}",
//                     fontSize: 18.sp,
//                     color: "#CF0607".toColor(),
//                     fontWeight: FontWeight.w600,
//                     textAlign: TextAlign.right,
//                   ),
//                 ),
//               ],
//             ),
//             10.heightSpace(),
//             Row(
//               children: [
//                 CustomText(
//                   text: "Year: ",
//                   color: "#444952".toColor(),
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14.sp,
//                 ),
//
//                 CustomText(
//                   text: car.year,
//                   color: "#444952".toColor(),
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14.sp,
//                 ),
//
//                 24.widthSpace(),
//
//                 CustomText(
//                   text: "Mileage: ",
//                   color: "#444952".toColor(),
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14.sp,
//                 ),
//
//                 CustomText(
//                   text: "${car.mileage} Km",
//                   color: "#444952".toColor(),
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14.sp,
//                 ),
//
//                 Spacer(),
//                 if (car.isPaid) ...[
//                   CustomText(
//                     text: car.trackingId ?? "",
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14.sp,
//                   ),
//                   6.widthSpace(),
//                   InkWell(
//                     onTap: () {
//                       Clipboard.setData(
//                         ClipboardData(text: car.trackingId ?? ""),
//                       );
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("Copied to the clipboard")),
//                       );
//                     },
//                     child: SvgPicture.asset(IconPath.copy),
//                   ),
//                 ],
//               ],
//             ),
//
//             10.heightSpace(),
//             Row(
//               children: [
//                 SvgPicture.asset(IconPath.trackCar),
//                 6.widthSpace(),
//                 CustomText(
//                   text: car.location,
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.normal,
//                   color: "#444952".toColor(),
//                 ),
//               ],
//             ),
//
//             Padding(
//               padding: EdgeInsetsGeometry.symmetric(vertical: 10.h),
//               child: Divider(color: "#EDEDED".toColor()),
//             ),
//
//             if (car.isPaid) ...[
//               CustomSubmitButton(
//                 text: "Track",
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (_) => TrackCarDialog(),
//                   );
//                 },
//               ),
//             ] else ...[
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildButton(
//                       iconPath: IconPath.phone,
//                       title: "Call",
//                       onTap: () {},
//                     ),
//                   ),
//                   12.widthSpace(),
//                   Expanded(
//                     child: _buildButton(
//                       iconPath: IconPath.sms,
//                       title: "SMS",
//                       onTap: () {},
//                     ),
//                   ),
//                   12.widthSpace(),
//                   Expanded(
//                     child: _buildButton(
//                       iconPath: IconPath.whatsapp,
//                       title: "",
//                       onTap: () {},
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
//
//   InkWell _buildButton({
//     required String iconPath,
//     required String title,
//     required Function() onTap,
//   }) => InkWell(
//     onTap: onTap,
//     child: Container(
//       padding: EdgeInsets.symmetric(vertical: 6.h),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: "#B6B8BC".toColor()),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(iconPath),
//           if (title.isNotEmpty) ...[
//             10.widthSpace(),
//             CustomText(
//               text: title,
//               fontWeight: FontWeight.normal,
//               fontSize: 14.sp,
//               color: "#000000".toColor(),
//             ),
//           ],
//         ],
//       ),
//     ),
//   );
// }
import 'package:carlanda_car_buy_sell/core/common/entity/car_entity.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/details/presentation/view/details_screen.dart';
import 'package:carlanda_car_buy_sell/features/home/controller/home_controller.dart';
import 'package:carlanda_car_buy_sell/features/track_car/presentation/components/track_car_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class CommonCarCard extends GetView<HomeController> {
  const CommonCarCard({super.key, required this.car});
  final CarEntity car;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => Get.to(() => DetailsScreen()),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: context.height * 0.22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                    // child: _buildImage(),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      car.isFavorite
                          ? IconPath.favoriteFill
                          : IconPath.favorite,
                    ),
                  ),
                ),
              ],
            ),
            10.heightSpace(),
            Row(
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
                Expanded(
                  child: CustomText(
                    text: car.isPaid ? "Paid" : "\$${car.price}",
                    fontSize: 18.sp,
                    color: "#CF0607".toColor(),
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            10.heightSpace(),
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
                Spacer(),
                if (car.isPaid) ...[
                  CustomText(
                    text: car.trackingId ?? "",
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                  6.widthSpace(),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(text: car.trackingId ?? ""),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Copied to the clipboard")),
                      );
                    },
                    child: SvgPicture.asset(IconPath.copy),
                  ),
                ],
              ],
            ),
            10.heightSpace(),
            Row(
              children: [
                SvgPicture.asset(IconPath.trackCar),
                6.widthSpace(),
                CustomText(
                  text: car.location,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: "#444952".toColor(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Divider(color: "#EDEDED".toColor()),
            ),
            if (car.isPaid) ...[
              CustomSubmitButton(
                text: "Track",
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => TrackCarDialog(),
                  );
                },
              ),
            ]
            else ...[
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
          ],
        ),
      ),
    );
  }

  // Widget _buildImage() {
  //   // Check if imagePath is a URL or asset path
  //   bool isNetworkImage = car.imagePath.startsWith('http://') ||
  //       car.imagePath.startsWith('https://');
  //
  //   if (isNetworkImage) {
  //     return CachedNetworkImage(
  //       imageUrl: car.imagePath,
  //       fit: BoxFit.cover,
  //       width: double.infinity,
  //       placeholder: (context, url) => Center(
  //         child: CircularProgressIndicator(
  //           color: "#CF0607".toColor(),
  //           strokeWidth: 2,
  //         ),
  //       ),
  //       errorWidget: (context, url, error) => Container(
  //         color: "#F5F5F5".toColor(),
  //         child: Center(
  //           child: Icon(
  //             Icons.directions_car,
  //             size: 50,
  //             color: "#B6B8BC".toColor(),
  //           ),
  //         ),
  //       ),
  //     );
  //   } else {
  //     // Use AssetImage for local assets
  //     return Image.asset(
  //       car.imagePath,
  //       fit: BoxFit.cover,
  //       width: double.infinity,
  //       errorBuilder: (context, error, stackTrace) => Container(
  //         color: "#F5F5F5".toColor(),
  //         child: Center(
  //           child: Icon(
  //             Icons.directions_car,
  //             size: 50,
  //             color: "#B6B8BC".toColor(),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }

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
