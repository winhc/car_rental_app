import 'package:car_rental_app/app/modules/explore/models/local_car_model.dart';
import 'package:car_rental_app/service/database_service.dart';
import 'package:dio/dio.dart';

import '../../../../service/dio_service.dart';
import '../models/rental_model.dart';

class CarProvider {
  final DatabaseService _databaseService = DatabaseService();
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

  Future<List<LocalCar>> getAllFavouriteCars() async {
    return await _databaseService.getAllCars();
  }

  Future<LocalCar> getFavouriteCarById(int id) async {
    return await _databaseService.getCarById(id);
  }

  Future<int> getFavouriteCarCountById(int id) async {
    return await _databaseService.getCarCountById(id);
  }

  Future<int> addFavouriteCar(LocalCar car) async {
    return await _databaseService.addCar(car);
  }

  Future<int> deleteFavouriteCar(int id) async {
    return await _databaseService.deleteCar(id);
  }

  Future<void> updateCar(int id, LocalCar car) async {
    await _databaseService.updateCar(id, car);
  }
}
