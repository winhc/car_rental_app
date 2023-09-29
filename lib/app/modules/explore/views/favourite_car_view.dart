import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/car_grid_view.dart';
import '../controllers/explore_controller.dart';

class FavouriteCarView extends GetView<ExploreController> {
  const FavouriteCarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your favourite"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(
          () => CarGridView(
            carList: controller.favouriteCarList,
            isLoading: controller.isFavouriteDataFetching.value,
            onTap: (car) {
              controller.onGridViewItemSelected(car);
            },
          ),
        ),
      ),
    );
  }
}
