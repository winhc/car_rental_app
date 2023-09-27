import 'package:car_rental_app/app/modules/signup/models/sign_up_model.dart';
import 'package:dio/dio.dart';

import '../../../../service/dio_service.dart';

class SignUpProvider {
  Future<Response> signIn(SignUp signUp) async {
    var bodyData = signUp.toJson();
    try {
      return await DIOService.createDio().post('/register', data: bodyData);
    } on DioException {
      rethrow;
    }
  }
}
