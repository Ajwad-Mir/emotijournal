import 'package:emotijournal/app/modules/home/controller/home_controller.dart';
import 'package:emotijournal/app/modules/journal_entry/controller/journal_entry_controller.dart';
import 'package:emotijournal/app/modules/login/controller/login_controller.dart';
import 'package:emotijournal/app/modules/register/controller/register_controller.dart';
import 'package:emotijournal/app/modules/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => LoginController(),fenix: true);
    Get.lazyPut(() => RegisterController(),fenix: true);
    Get.lazyPut(() => HomeController(),fenix: true);
    Get.lazyPut(() => JournalEntryController(),fenix: true);
  }
}