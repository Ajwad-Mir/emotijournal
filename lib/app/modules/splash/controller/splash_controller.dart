import 'package:emotijournal/app/modules/login/pages/login_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(2.seconds, () {
      Get.offAll(
        () => const LoginPage(),
        transition: Transition.fade,
        duration: 850.milliseconds,
      );
    });
  }
}
