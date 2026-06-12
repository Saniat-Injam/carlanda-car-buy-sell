import 'package:carlanda_car_buy_sell/core/common/entity/car_entity.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/will_d_pictures.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  RxBool isSearching = false.obs;

  final List<CarEntity> searchResult = <CarEntity>[
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
      isFavorite: false,
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
  final TextEditingController searchTEC = TextEditingController();

  void search({required String queary}) {
    if (queary.isEmpty) {
      isSearching.value = false;
    } else {
      isSearching.value = true;
    }
  }
}
