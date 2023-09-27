import 'dart:convert';

import 'package:car_rental_app/app/modules/explore/models/car_model.dart';

class Booking {
  int? id;
  int? carId;
  String? startDate;
  String? endDate;
  int? amount;
  int? duration;
  Car? car;
  Booking({
    this.id,
    this.carId,
    this.startDate,
    this.endDate,
    this.amount,
    this.duration,
    this.car,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'carId': carId,
      'startDate': startDate,
      'endDate': endDate,
      'amount': amount,
      'duration': duration,
      'car': car?.toMap(),
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id']?.toInt(),
      carId: map['car_id']?.toInt(),
      startDate: map['start_date'],
      endDate: map['end_date'],
      amount: map['amount']?.toInt(),
      duration: map['duration']?.toInt(),
      car: map['car'] != null ? Car.fromMap(map['car']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Booking(id: $id, carId: $carId, startDate: $startDate, endDate: $endDate, amount: $amount, duration: $duration, car: $car)';
  }
}
