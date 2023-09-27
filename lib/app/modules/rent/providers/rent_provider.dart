import 'package:dio/dio.dart';

import '../../../../service/dio_service.dart';

class RentProvider {
  Future<Response> getBookingList() async {
    try {
      return await DIOService.createDio().get('/bookings');
    } on DioException {
      rethrow;
    }
  }

  Future<Response> getBookingById(int id) async {
    try {
      return await DIOService.createDio().get('/bookings/$id');
    } on DioException {
      rethrow;
    }
  }

  Future<Response> updateBookingDate(
      {required int bookingId,
      required int carId,
      required String startDate,
      required String endDate}) async {
    try {
      return await DIOService.createDio()
          .put('/bookings/$bookingId?start_date=$startDate&end_date=$endDate');
    } on DioException {
      rethrow;
    }
  }

  Future<Response> deleteBooking(
    int bookingId,
  ) async {
    try {
      return await DIOService.createDio().delete('/bookings/$bookingId');
    } on DioException {
      rethrow;
    }
  }
}
