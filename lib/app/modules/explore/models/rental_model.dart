import 'dart:convert';

class Rental {
  int? carId;
  String? startDate;
  String? endDate;
  Rental({
    this.carId,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'car_id': carId,
      'start_date': startDate,
      'end_date': endDate,
    };
  }

  factory Rental.fromMap(Map<String, dynamic> map) {
    return Rental(
      carId: map['car_id']?.toInt(),
      startDate: map['start_date'],
      endDate: map['end_date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Rental.fromJson(String source) => Rental.fromMap(json.decode(source));

  @override
  String toString() =>
      'Rental(carId: $carId, startDate: $startDate, endDate: $endDate)';
}
