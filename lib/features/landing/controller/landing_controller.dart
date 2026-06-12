import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingController extends GetxController {
  final OverlayPortalController overlayController = OverlayPortalController();
  RxInt currentIndex = 0.obs;

  List<String> unselectedIcon = <String>[
    IconPath.home,
    IconPath.cars,
    IconPath.trackCar,
    IconPath.favorite,
    IconPath.profile,
  ];

  List<String> selectedIcon = <String>[
    IconPath.selectedHome,
    IconPath.selectedCar,
    IconPath.selectedtrack,
    IconPath.selectedFavorite,
    IconPath.selectedProfile,
  ];
  void changeIndex({required int index}) => currentIndex.value = index;
}
