import 'package:emotijournal/app/modules/home/controller/home_controller.dart';
import 'package:emotijournal/app/modules/journal_entry/controller/journal_entry_controller.dart';
import 'package:emotijournal/app/modules/login/controller/login_controller.dart';
import 'package:emotijournal/app/modules/register/controller/register_controller.dart';
import 'package:emotijournal/app/modules/settings/controller/settings_controller.dart';
import 'package:emotijournal/app/modules/splash/controller/splash_controller.dart';
import 'package:emotijournal/app/modules/subscriptions/controller/subscription_controller.dart';
import 'package:emotijournal/app/modules/update_profile/controller/update_profile_controller.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => HomeController(),fenix: true);
    Get.lazyPut(() => JournalManagementController(),fenix: true);
    Get.lazyPut(() => SubscriptionsController(),fenix: true);
    Get.lazyPut(() => SettingsController(),fenix: true);
    Get.lazyPut(() => UpdateProfileController(),fenix: true) ;
  }
}