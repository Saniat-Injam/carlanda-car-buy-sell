import 'package:carlanda_car_buy_sell/features/authentication/binder/auth_binder.dart';
import 'package:carlanda_car_buy_sell/features/details/binder/details_controller_binder.dart';
import 'package:carlanda_car_buy_sell/features/favorite/binder/favorite_controller_binder.dart';
import 'package:carlanda_car_buy_sell/features/home/binder/home_controller_binder.dart';
import 'package:carlanda_car_buy_sell/features/landing/binder/landing_controller_binder.dart';
import 'package:carlanda_car_buy_sell/features/notifications/binder/notification_controller_binder.dart';
import 'package:carlanda_car_buy_sell/features/profile/binder/profile_controller_binder.dart';
import 'package:carlanda_car_buy_sell/features/profile_setup/binder/profile_stup_binder.dart';
import 'package:carlanda_car_buy_sell/features/search/binder/search_controller_binder.dart';
import 'package:carlanda_car_buy_sell/features/support_chat/binder/support_chat_controller_binder.dart';
import 'package:carlanda_car_buy_sell/features/track_car/binder/track_car_controller_binder.dart';
import 'package:carlanda_car_buy_sell/features/view_cars/binder/view_cars_controller_binder.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    //Auth Controllers binder
    AuthBinder().dependencies();

    //Profile setup controllers binder
    ProfileStupBinder().dependencies();

    //Landing controller binder
    LandingControllerBinder().dependencies();

    //Home controllers binder
    HomeControllerBinder().dependencies();

    //View Cars controller binder
    ViewCarsControllerBinder().dependencies();

    //Track Cars controller binder
    TrackCarControllerBinder().dependencies();

    //Favorite Controller binder
    FavoriteControllerBinder().dependencies();

    //Profile controller binder
    ProfileControllerBinder().dependencies();

    //Notification Controller bindings
    NotificationControllerBinder().dependencies();

    //Search controller binder
    SearchControllerBinder().dependencies();

    //Detais page controller binder
    DetailsControllerBinder().dependencies();

    //Support Chat controller binder
    SupportChatControllerBinder().dependencies();
  }
}
