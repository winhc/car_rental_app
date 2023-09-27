import 'package:car_rental_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init();
  runApp(const App());
}
