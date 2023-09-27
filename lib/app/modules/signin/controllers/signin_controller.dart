import 'package:car_rental_app/app/modules/signin/models/login_model.dart';
import 'package:car_rental_app/app/modules/signin/providers/signin_provider.dart';
import 'package:car_rental_app/app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../service/login_auth_service.dart';
import '../../../../service/login_user_helper.dart';
import '../../../../utils/loading_dialog_util.dart';
import '../models/login_response_model.dart';

class SigninController extends GetxController {
  final _signProvider = SignInProvider();

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  Future<void> signIn() async {
    LoadingDialogUtil.showAppLoadingDialog(Get.overlayContext!);
    Login login = Login(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text);
    try {
      final response = await _signProvider.signIn(login);
      LoadingDialogUtil.closeAppLoadingDialog(Get.overlayContext!);
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromMap(response.data);
        AuthTokenService().setAuthTokenToBox(loginResponse.authToken);
        LoginUserHelper().setUserDataToBox(loginResponse.user!);

        Get.snackbar(
          "Sign In",
          loginResponse.message ?? "Success",
        );
        Get.offAllNamed(Routes.HOME);
      }
    } on DioException catch (error) {
      LoadingDialogUtil.closeAppLoadingDialog(Get.overlayContext!);
      if (error.response != null) {
        Get.snackbar(
          "Sign In",
          error.response!.data['message'] ?? "Unknown error!",
        );
      }
      throw Exception(error);
    }
  }

  goToSignUp() {
    Get.toNamed(Routes.SIGNUP);
  }
}
