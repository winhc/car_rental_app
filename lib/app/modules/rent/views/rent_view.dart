import 'package:car_rental_app/app/widgets/car_booking_list_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rent_controller.dart';

class RentView extends GetView<RentController> {
  const RentView({Key? key}) : super(key: key);
  // final _exploreController = Get.find<ExploreController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
            () => CarBookingListView(
              bookingList: controller.bookingList,
              isLoading: controller.isFetching.value,
              onTap: (booking) {
                controller.onListViewItemSelected(booking);
              },
            ),
          ),
        ),
      ),
    );
  }
}
