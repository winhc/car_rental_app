import 'package:car_rental_app/app/modules/account/views/account_view.dart';
import 'package:car_rental_app/app/modules/explore/controllers/explore_controller.dart';
import 'package:car_rental_app/app/modules/explore/views/explore_view.dart';
import 'package:car_rental_app/app/modules/rent/controllers/rent_controller.dart';
import 'package:car_rental_app/app/modules/rent/views/rent_view.dart';
import 'package:get/get.dart';

import '../../account/controllers/account_controller.dart';

class HomeController extends GetxController {
  var navPageList = [];
  final currentPageIndex = 0.obs;

  onSelectedBottomNavigationBar(int selectedIndex) {
    currentPageIndex(selectedIndex);
    switch (selectedIndex) {
      case 0:
        Get.find<ExploreController>().getCarList();
      case 1:
        final rentController = Get.put<RentController>(RentController());
        rentController.getBookingList();
      case 2:
        Get.lazyPut<AccountController>(
          () => AccountController(),
        );
    }
  }

  @override
  void onInit() {
    navPageList = [
      const ExploreView(),
      RentView(),
      const AccountView(),
    ];

    super.onInit();
  }
}
