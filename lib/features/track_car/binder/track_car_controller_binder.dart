import 'package:carlanda_car_buy_sell/features/track_car/controllers/track_car_controller.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';

class TrackCarControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackCarController>(() => TrackCarController(), fenix: true);
  }
}
