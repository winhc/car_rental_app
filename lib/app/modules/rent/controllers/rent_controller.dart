import 'package:car_rental_app/app/modules/rent/models/booking.dart';
import 'package:car_rental_app/app/modules/rent/providers/rent_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/loading_dialog_util.dart';
import '../views/rent_detil_view.dart';

class RentController extends GetxController {
  final _rentProvider = RentProvider();
  final isFetching = false.obs;
  final bookingList = <Booking>[].obs;
  String heroTagName = "";
  final selectedBooking = Booking().obs;

  Future<void> getBookingList() async {
    try {
      isFetching(true);
      bookingList.clear();
      final response = await _rentProvider.getBookingList();
      isFetching(false);
      if (response.statusCode == 200) {
        final dataList = response.data["data"] as List;
        for (var data in dataList) {
          bookingList.add(Booking.fromMap(data));
        }
      }
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

  void onListViewItemSelected(Booking booking) {
    selectedBooking(booking);
    heroTagName = "image${booking.car!.id}";
    Get.to(const RentCarDetailView());
  }

  void onClickDateIconButton(BuildContext context) async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime.parse(
          selectedBooking.value.startDate!), // the earliest allowable
      lastDate:
          DateTime.now().add(const Duration(days: 365)), // the latest allowable
      currentDate: DateTime.now().add(const Duration(days: 1)),
      initialDateRange: DateTimeRange(
          start: DateTime.parse(selectedBooking.value.startDate!),
          end: DateTime.parse(selectedBooking.value.endDate!)),
      saveText: 'Done',
    );
    if (result != null) {
      String startDate = result.start.toString().split(' ')[0];
      String endDate = result.end.toString().split(' ')[0];
      // debugPrint("$startDate, $endEnd");
      updateBookingDate(startDate, endDate);
    }
  }

  Future<void> updateBookingDate(String startDate, String endDate) async {
    try {
      LoadingDialogUtil.showAppLoadingDialog(Get.overlayContext!);
      final response = await _rentProvider.updateBookingDate(
          bookingId: selectedBooking.value.id!,
          carId: selectedBooking.value.car!.id!,
          startDate: startDate,
          endDate: endDate);
      LoadingDialogUtil.closeAppLoadingDialog(Get.overlayContext!);
      if (response.statusCode == 200) {
        await getBookingById(selectedBooking.value.id!);
        await getBookingList();
        Get.snackbar(
          "Update booking",
          response.data['message'] ?? "Success",
        );
      }
    } on DioException catch (error) {
      LoadingDialogUtil.closeAppLoadingDialog(Get.overlayContext!);
      if (error.response != null) {
        Get.snackbar(
          "Car Rental",
          error.response!.data['message'] ?? "Unknown error!",
        );
      }
      throw Exception(error);
    }
  }

  Future<void> getBookingById(int id) async {
    try {
      final response = await _rentProvider.getBookingById(id);

      if (response.statusCode == 200) {
        selectedBooking(Booking.fromMap(response.data["data"]));
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

  Future<void> onDeleteBookingClick(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Do you want to delete this booking?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                deleteBooking();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteBooking() async {
    try {
      LoadingDialogUtil.showAppLoadingDialog(Get.overlayContext!);
      final response =
          await _rentProvider.deleteBooking(selectedBooking.value.id!);
      LoadingDialogUtil.closeAppLoadingDialog(Get.overlayContext!);
      if (response.statusCode == 200) {
        Get.back();
        removeBookingItem();
        Get.snackbar(
          "Delete booking",
          response.data['message'] ?? "Success",
        );
      }
    } on DioException catch (error) {
      LoadingDialogUtil.closeAppLoadingDialog(Get.overlayContext!);
      if (error.response != null) {
        Get.snackbar(
          "Car Rental",
          error.response!.data['message'] ?? "Unknown error!",
        );
      }
      throw Exception(error);
    }
  }

  void removeBookingItem() {
    bookingList.remove(selectedBooking.value);
    update();
  }
}
