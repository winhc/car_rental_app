import 'dart:convert';

class SignUp {
  String? name;
  String? email;
  String? password;
  String? passwordConfirmation;
  SignUp({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }

  factory SignUp.fromMap(Map<String, dynamic> map) {
    return SignUp(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      passwordConfirmation: map['password_confirmation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUp.fromJson(String source) => SignUp.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SignUp(name: $name, email: $email, password: $password, passwordConfirmation: $passwordConfirmation)';
  }
}
