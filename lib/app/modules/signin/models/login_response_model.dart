import 'dart:convert';

import 'package:car_rental_app/app/modules/signin/models/user_model.dart';

class LoginResponse {
  String? message;
  User? user;
  String? authToken;
  LoginResponse({
    this.message,
    this.user,
    this.authToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'user': user?.toMap(),
      'auth_token': authToken,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      message: map['message'],
      user: map['user'] != null ? User.fromMap(map['user']) : null,
      authToken: map['auth_token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginResponse(message: $message, user: $user, authToken: $authToken)';
}
