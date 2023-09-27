import 'package:car_rental_app/app/modules/explore/controllers/explore_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put<ExploreController>(ExploreController());
  }
}
