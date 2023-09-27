import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class WelcomeController extends GetxController {
  goToSign() {
    Get.offNamed(Routes.SIGNIN);
  }
}
