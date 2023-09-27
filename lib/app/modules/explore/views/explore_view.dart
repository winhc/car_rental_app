import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/car_grid_view.dart';
import '../controllers/explore_controller.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
            () => CarGridView(
              carList: controller.carList,
              isLoading: controller.isFetching.value,
              onTap: (car) {
                controller.onGridViewItemSelected(car);
              },
            ),
          ),
        ),
      ),
    );
  }
}
