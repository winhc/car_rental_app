import 'dart:convert';

class Car {
  int? id;
  String? model;
  String? brand;
  String? registrationNo;
  String? imgUrl;
  String? status;
  String? details;
  int? rentalRate;
  int? doorCount;
  String? fuelType;
  int? seatCount;
  String? gearBoxType;
  Car({
    this.id,
    this.model,
    this.brand,
    this.registrationNo,
    this.imgUrl,
    this.status,
    this.details,
    this.rentalRate,
    this.doorCount,
    this.fuelType,
    this.seatCount,
    this.gearBoxType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'model': model,
      'brand': brand,
      'registration_no': registrationNo,
      'img_url': imgUrl,
      'status': status,
      'details': details,
      'rental_rate': rentalRate,
      'door_count': doorCount,
      'fuel_type': fuelType,
      'seat_count': seatCount,
      'gear_box_type': gearBoxType,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id']?.toInt(),
      model: map['model'],
      brand: map['brand'],
      registrationNo: map['registration_no'],
      imgUrl: map['img_url'],
      status: map['status'],
      details: map['details'],
      rentalRate: map['rental_rate'],
      doorCount: map['door_count'],
      fuelType: map['fuel_type'],
      seatCount: map['seat_count'],
      gearBoxType: map['gear_box_type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) => Car.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Car(id: $id, model: $model, brand: $brand, registrationNo: $registrationNo, imgUrl: $imgUrl, status: $status, details: $details, rentalRate: $rentalRate, doorCount: $doorCount, fuelType: $fuelType, seatCount: $seatCount, gearBoxType: $gearBoxType)';
  }
}
