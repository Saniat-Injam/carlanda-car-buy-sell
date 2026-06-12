import 'package:carlanda_car_buy_sell/core/common/entity/car_entity.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/will_d_pictures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewCarsController extends GetxController {
  final TextEditingController search = TextEditingController();
  final List<String> filterResults = <String>[
    "Default",
    "Newest to Oldest",
    "Oldest to newest",
    "Price highest to lowest",
    "Price lowest to highest",
    "Year highest to lowest",
    "Year lowest to highest",
  ];

  final RxString selectedFilter = "".obs;

  final List<CarEntity> featuredCars = <CarEntity>[
    CarEntity(
      id: "1",
      imagePath: WillDPictures.cars1,
      title: "Audi . RS Q8 . TFSI V8",
      price: 24000,
      year: "2025",
      isFavorite: false,
      mileage: 1700,
      location: "Ras AI Khor, Dubai",
      chatRoomId: "",
      phoneNumber: 0188,
      whatsappNumber: 10111,
    ),
    CarEntity(
      id: "1",
      imagePath: WillDPictures.cars2,
      title: "Audi . RS Q8 . TFSI V8",
      price: 24000,
      year: "2025",
      isFavorite: true,
      mileage: 1700,
      location: "Ras AI Khor, Dubai",
      chatRoomId: "",
      phoneNumber: 0188,
      whatsappNumber: 10111,
    ),
    CarEntity(
      id: "1",
      imagePath: WillDPictures.cars4,
      title: "Audi . RS Q8 . TFSI V8",
      price: 24000,
      year: "2025",
      isFavorite: false,
      mileage: 1700,
      location: "Ras AI Khor, Dubai",
      chatRoomId: "",
      phoneNumber: 0188,
      whatsappNumber: 10111,
    ),
  ];

  void selectFilter({required String option}) => selectedFilter.value = option;

  @override
  void onClose() {
    search.dispose();
    super.onClose();
  }
}
