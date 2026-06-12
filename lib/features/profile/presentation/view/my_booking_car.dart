import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/my_booking_car_controller.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/components/common_booking_cars_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MyBookingCar extends StatelessWidget {
  const MyBookingCar({super.key});

  @override
  Widget build(BuildContext context) {
    final MyBookingCarController controller = Get.find<MyBookingCarController>();

    return Scaffold(
      appBar: CustomAppbar(title: "My Booking Cars"),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            10.heightSpace(),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => CommonBookingCarsCard(car: controller.bookingCars[index]),
                separatorBuilder: (context, index) => 16.heightSpace(),
                itemCount: controller.bookingCars.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
