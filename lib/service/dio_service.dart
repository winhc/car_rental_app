import 'dart:developer';
import 'package:car_rental_app/service/login_auth_service.dart';
import 'package:dio/dio.dart';

import '../config/api_config.dart';

class DIOService {
  DIOService._instance();

  static final DIOService _dioService = DIOService._instance();

  factory DIOService(String token) => _dioService;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
        baseUrl: ApiConfig.baseURl,
        receiveTimeout: const Duration(minutes: 1),
        connectTimeout: const Duration(minutes: 1),
        sendTimeout: const Duration(minutes: 1),
        headers: {"Authorization": AuthTokenService().getAuthTokenFromBox()}));
    dio.interceptors.addAll({
      AppInterceptors(dio),
      LogInterceptor(
          request: true,
          responseBody: true,
          requestBody: true,
          error: true,
          logPrint: (dioLog) {
            log('$dioLog');
          }),
    });
    return dio;
  }
}

class AppInterceptors extends QueuedInterceptorsWrapper {
  final Dio dio;
  AppInterceptors(
    this.dio,
  );

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }
}
