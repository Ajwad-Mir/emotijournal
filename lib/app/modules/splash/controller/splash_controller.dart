import 'package:emotijournal/app/services/session_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(0.seconds, () async{
      await Get.find<SessionService>().getUserFromToken();
    });
  }
}
