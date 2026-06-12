import 'package:get/get.dart';

import '../../../core/common/entity/car_entity.dart';
import '../../../core/utils/constants/will_d_pictures.dart';

class MyBookingCarController extends GetxController {
  final List<CarEntity> bookingCars = <CarEntity>[
    CarEntity(
      id: "#134509",
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
      isPaid: true,
      trackingId: "#1k3j5",
    ),
  ];
}