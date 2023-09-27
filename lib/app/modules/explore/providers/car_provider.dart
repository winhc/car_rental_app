import 'package:dio/dio.dart';

import '../../../../service/dio_service.dart';
import '../models/rental_model.dart';

class CarProvider {
  Future<Response> getCarList() async {
    try {
      return await DIOService.createDio().get('/cars');
    } on DioException {
      rethrow;
    }
  }

  Future<Response> getCarListById(int id) async {
    try {
      return await DIOService.createDio().get('/cars/$id');
    } on DioException {
      rethrow;
    }
  }

  Future<Response> rentCar(Rental rental) async {
    var bodyData = rental.toJson();
    try {
      return await DIOService.createDio().post('/bookings', data: bodyData);
    } on DioException {
      rethrow;
    }
  }
}
