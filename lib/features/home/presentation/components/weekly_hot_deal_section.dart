import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/features/details/presentation/view/details_screen.dart';
import 'package:carlanda_car_buy_sell/features/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WeeklyHotDealSection extends StatelessWidget {
  const WeeklyHotDealSection({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return SizedBox(
      height: context.height * 0.22,
      child: Obx(() {
        if (homeController.deals.isEmpty) {
          return Center(child: CircularProgressIndicator(color: AppColors.primary,));
        }

        final imagePaths = homeController.deals
            .where((deal) => deal.carImages.isNotEmpty)
            .map((deal) => deal.carImages.first)
            .toList();

        return CustomImageSlider(
          imagePaths: imagePaths,
          isAsset: false, // Use network images
        );
      }),
    );
  }
}


class CustomImageSlider extends StatelessWidget {
  final List<String> imagePaths;
  final double height;
  final bool isAsset;

  const CustomImageSlider({
    super.key,
    required this.imagePaths,
    this.height = 200,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        //  enlargeCenterPage: true,
        autoPlay: true,
        //  aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        viewportFraction: 0.9,
      ),

      items: imagePaths.map((path) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => Get.to(() => DetailsScreen()),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: isAsset
                      ? Image.asset(path, fit: BoxFit.cover)
                      : Image.network(path, fit: BoxFit.cover),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
