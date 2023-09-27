import 'package:car_rental_app/app/modules/signup/models/sign_up_model.dart';
import 'package:car_rental_app/app/modules/signup/providers/sign_up_provider.dart';
import 'package:car_rental_app/app/routes/app_pages.dart';
import 'package:car_rental_app/service/login_user_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../service/login_auth_service.dart';
import '../../../../utils/loading_dialog_util.dart';
import '../../signin/models/login_response_model.dart';

class SignupController extends GetxController {
  final _signUpProvider = SignUpProvider();

  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();

  Future<void> signUp() async {
    LoadingDialogUtil.showAppLoadingDialog(Get.overlayContext!);
    SignUp signUp = SignUp(
        name: nameTextEditingController.text,
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
        passwordConfirmation: confirmPasswordTextEditingController.text);
    try {
      final response = await _signUpProvider.signIn(signUp);
      LoadingDialogUtil.closeAppLoadingDialog(Get.overlayContext!);
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromMap(response.data);
        AuthTokenService().setAuthTokenToBox(loginResponse.authToken);
        LoginUserHelper().setUserDataToBox(loginResponse.user!);
        Get.snackbar(
          "Sign Up",
          loginResponse.message ?? "Success",
        );
        Get.offAllNamed(Routes.HOME);
      }
    } on DioException catch (error) {
      LoadingDialogUtil.closeAppLoadingDialog(Get.overlayContext!);
      if (error.response != null) {
        Get.snackbar(
          "Sign Up",
          error.response!.data['message'] ?? "Unknown error!",
        );
      }
      throw Exception(error);
    }
    Get.offAllNamed(Routes.HOME);
  }
}
