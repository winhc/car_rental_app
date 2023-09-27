import 'package:car_rental_app/app/modules/signin/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

class LoginUserHelper {
  LoginUserHelper._instance();
  static final LoginUserHelper _loginUserHelper = LoginUserHelper._instance();
  factory LoginUserHelper() => _loginUserHelper;

  final box = GetStorage();

  final String key = 'USER_KEY';

  setUserDataToBox(User user) {
    box.write(key, user.toJson());
  }

  User? getUserDataFromBox() {
    var data = box.read(key) ?? "";
    if (data != "") {
      return User.fromJson(data);
    }
    return null;
  }

  clearLoginUserData() {
    box.remove(key);
  }
}
