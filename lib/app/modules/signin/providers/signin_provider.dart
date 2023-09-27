import 'package:dio/dio.dart';

import '../../../../service/dio_service.dart';
import '../models/login_model.dart';

class SignInProvider {
  Future<Response> signIn(Login login) async {
    var bodyData = login.toJson();
    try {
      return await DIOService.createDio().post('/login', data: bodyData);
    } on DioException {
      rethrow;
    }
  }
}
