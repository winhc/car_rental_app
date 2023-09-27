import 'package:dio/dio.dart';

import '../../../../service/dio_service.dart';

class AccountProvider {
  Future<Response> logout() async {
    try {
      return await DIOService.createDio().post('/logout');
    } on DioException {
      rethrow;
    }
  }
}
