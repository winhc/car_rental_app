import 'dart:convert';

import 'package:car_rental_app/app/modules/explore/models/car_model.dart';

class LocalCar {
  int? id;
  Car? car;
  LocalCar({
    this.id,
    this.car,
  });

  LocalCar copyWith({
    int? id,
    Car? car,
  }) {
    return LocalCar(
      id: id ?? this.id,
      car: car ?? this.car,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'car': car?.toJson(),
    };
  }

  factory LocalCar.fromMap(Map<String, dynamic> map) {
    return LocalCar(
      id: map['id']?.toInt(),
      car: map['car'] != null ? Car.fromJson(map['car']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalCar.fromJson(String source) =>
      LocalCar.fromMap(json.decode(source));

  @override
  String toString() => 'LocalCar(id: $id, car: $car)';
}
