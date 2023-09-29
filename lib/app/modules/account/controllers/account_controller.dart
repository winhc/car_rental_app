import 'package:car_rental_app/app/modules/account/providers/account_provider.dart';
import 'package:car_rental_app/app/modules/explore/views/favourite_car_view.dart';
import 'package:car_rental_app/app/modules/signin/models/user_model.dart';
import 'package:car_rental_app/service/login_auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../service/login_user_helper.dart';
import '../../../../utils/loading_dialog_util.dart';
import '../../../routes/app_pages.dart';
import '../../explore/controllers/explore_controller.dart';

class AccountController extends GetxController {
  final _accountProvider = AccountProvider();

  final userName = "".obs;
  final userEmail = "".obs;

  @override
  void onInit() {
    User? user = LoginUserHelper().getUserDataFromBox();

    if (user != null) {
      userName(user.name);
      userEmail(user.email);
    }
    super.onInit();
  }

  onLogoutClick(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Do you want to logout?'),
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
                logout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> logout() async {
    try {
      LoadingDialogUtil.showAppLoadingDialog(Get.overlayContext!);
      final response = await _accountProvider.logout();
      LoadingDialogUtil.closeAppLoadingDialog(Get.overlayContext!);
      if (response.statusCode == 200) {
        AuthTokenService().clearAuth();
        LoginUserHelper().clearLoginUserData();
        Get.snackbar(
          "Logout",
          response.data['message'] ?? "Success",
        );

        Get.offAllNamed(Routes.WELCOME);
      }
    } on DioException catch (error) {
      LoadingDialogUtil.closeAppLoadingDialog(Get.overlayContext!);
      if (error.response != null) {
        Get.snackbar(
          "Logout",
          error.response!.data['message'] ?? "Unknown error!",
        );
      }
      throw Exception(error);
    }
  }

  goToFavouriteView() {
    Get.find<ExploreController>().getFavouriteCarList();
    Get.to(const FavouriteCarView());
  }
}
