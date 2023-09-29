import 'package:car_rental_app/app/modules/explore/models/car_model.dart';
import 'package:car_rental_app/app/modules/explore/models/local_car_model.dart';
import 'package:car_rental_app/app/modules/explore/models/rental_model.dart';
import 'package:car_rental_app/app/modules/explore/providers/car_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/loading_dialog_util.dart';
import '../views/explore_car_detail_view.dart';

class ExploreController extends GetxController {
  final _carProvider = CarProvider();
  final carList = <Car>[].obs;
  final isFetching = false.obs;
  final selectedCar = Car().obs;
  String heroTagName = "";
  final isFavourite = false.obs;
  final isFavouriteDataFetching = false.obs;
  final favouriteCarList = <Car>[].obs;

  @override
  onInit() {
    getCarList();
    super.onInit();
  }

  Future<void> getCarList() async {
    try {
      isFetching(true);
      carList.clear();
      final response = await _carProvider.getCarList();
      isFetching(false);
      if (response.statusCode == 200) {
        final dataList = response.data["data"] as List;
        for (var car in dataList) {
          carList.add(Car.fromMap(car));
        }
      }
      // debugPrint("carList => $carList");
    } on DioException catch (error) {
      isFetching(false);
      if (error.response != null) {
        Get.snackbar(
          "Car Rental",
          error.response!.data['message'] ?? "Unknown error!",
        );
      }
      throw Exception(error);
    }
  }

  Future<void> getCarListById(int id) async {
    try {
      final response = await _carProvider.getCarListById(id);

      if (response.statusCode == 200) {
        selectedCar(Car.fromMap(response.data["data"]));
      }
    } on DioException catch (error) {
      if (error.response != null) {
        Get.snackbar(
          "Car Rental",
          error.response!.data['message'] ?? "Unknown error!",
        );
      }
      throw Exception(error);
    }
  }

  onGridViewItemSelected(Car car) {
    selectedCar(car);
    checkIsFavurite();
    heroTagName = "image${car.id}";
    Get.to(const ExploreCarDetailView());
  }

  void onClickRentNowButton(BuildContext context) async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(), // the earliest allowable
      lastDate:
          DateTime.now().add(const Duration(days: 365)), // the latest allowable
      currentDate: DateTime.now(),
      saveText: 'Done',
    );
    if (result != null) {
      String startDate = result.start.toString().split(' ')[0];
      String endDate = result.end.toString().split(' ')[0];
      // debugPrint("$startDate, $endEnd");
      rentCar(startDate, endDate);
    }
  }

  Future<void> rentCar(String startDate, String endDate) async {
    try {
      LoadingDialogUtil.showAppLoadingDialog(Get.overlayContext!);
      Rental rental = Rental(
          carId: selectedCar.value.id, startDate: startDate, endDate: endDate);
      final response = await _carProvider.rentCar(rental);
      LoadingDialogUtil.closeAppLoadingDialog(Get.overlayContext!);
      if (response.statusCode == 200) {
        await getCarListById(selectedCar.value.id!);
        Get.snackbar(
          "Rent",
          response.data['message'] ?? "Success",
        );
      }
    } on DioException catch (error) {
      LoadingDialogUtil.closeAppLoadingDialog(Get.overlayContext!);
      if (error.response != null) {
        Get.snackbar(
          "Rent",
          error.response!.data['message'] ?? "Unknown error!",
        );
      }
      throw Exception(error);
    }
  }

  Future<void> getFavouriteCarList() async {
    try {
      isFavouriteDataFetching(true);
      favouriteCarList.clear();
      List<LocalCar> response = await _carProvider.getAllFavouriteCars();
      isFavouriteDataFetching(false);
      for (var localCar in response) {
        favouriteCarList.add(localCar.car!);
      }
    } catch (error) {
      isFetching(false);
      Get.snackbar(
        "Car Rental",
        "Favourite data fetch error!",
      );
      throw Exception(error);
    }
  }

  void checkIsFavurite() async {
    int carCount =
        await _carProvider.getFavouriteCarCountById(selectedCar.value.id!);
    if (carCount > 0) {
      isFavourite(true);
    } else {
      isFavourite(false);
    }
  }

  void onFavouriteIconClick() {
    LocalCar localCar =
        LocalCar(id: selectedCar.value.id, car: selectedCar.value);
    if (isFavourite.value) {
      _carProvider.deleteFavouriteCar(selectedCar.value.id!);
    } else {
      _carProvider.addFavouriteCar(localCar);
    }
    checkIsFavurite();
    getFavouriteCarList();
  }
}
