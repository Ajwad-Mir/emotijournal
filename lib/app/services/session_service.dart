import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotijournal/app/database/auth_database.dart';
import 'package:emotijournal/app/database/users_database.dart';
import 'package:emotijournal/app/models/user_model.dart';
import 'package:emotijournal/app/modules/home/pages/home_page.dart';
import 'package:emotijournal/app/modules/login/controller/login_controller.dart';
import 'package:emotijournal/app/modules/login/pages/login_page.dart';
import 'package:emotijournal/app/modules/register/controller/register_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SessionService extends GetxService {
  final sessionUser = UserModel.empty().obs;
  final userToken = ''.obs;

  Future<void> getUserFromToken() async {
    userToken.value = GetStorage().read<String>('userToken').toString();
    if (userToken.value.isEmpty) {
      Get.offAll(
        () => LoginPage(),
        transition: Transition.cupertino,
        duration: 850.milliseconds,
      );
      return;
    }
    final user = await UsersDatabase.getUserFromID(userToken.value);
    if (user == UserModel.empty()) {
      Get.offAll(
            () => LoginPage(),
        transition: Transition.cupertino,
        duration: 850.milliseconds,
      );
      return;
    }
    sessionUser.value = user;
    Get.offAll(
          () => HomePage(),
      transition: Transition.cupertino,
      duration: 850.milliseconds,
    );
    return;
  }

  Future<void> loginExistingSimple() async {
    final user = await AuthDatabase.loginExistingAccountSimple(
        email: Get.find<LoginController>().emailController.text, password: Get.find<LoginController>().passwordController.text);
    if (user != null) {
      Get.find<SessionService>().sessionUser.value = UserModel(
        userID: user.user!.uid,
        fullName: user.user!.displayName.toString(),
        emailAddress: Get.find<LoginController>().emailController.text,
        password: Get.find<LoginController>().passwordController.text,
        profileImageLink: user.user!.photoURL.toString(),
        createdAt: Timestamp.fromDate(user.user!.metadata.creationTime!),
        updatedAt: Timestamp.now(),
      );
      Get.offAll(
        () => HomePage(),
        transition: Transition.cupertino,
        duration: 850.milliseconds,
      );
    }
  }

  Future<void> loginExistingProvider({required String providerName}) async {
    final user = await AuthDatabase.loginExistingAccountProvider(providerName: "Google");
    if (user != null) {
      final userExists = await UsersDatabase.checkIfUserExists(user.user!.uid);
      if (userExists == false) {
        await UsersDatabase.createUser(
          newUserData: UserModel(
            userID: user.user!.uid,
            fullName: user.user!.displayName.toString(),
            emailAddress: user.user!.email.toString(),
            password: "",
            profileImageLink: user.user!.photoURL.toString(),
            createdAt: Timestamp.fromDate(user.user!.metadata.creationTime!),
            updatedAt: Timestamp.now(),
          ),
        );
      } else {
        Get.find<SessionService>().sessionUser.value = await UsersDatabase.getUserFromID(user.user!.uid);
      }
      Get.offAll(
        () => const HomePage(),
        transition: Transition.cupertino,
        duration: 850.milliseconds,
      );
    }
  }

  Future<void> createNewUserSimple() async {
    final user = await AuthDatabase.createNewAccountSimple(
        email: Get.find<RegisterController>().emailController.text, password: Get.find<RegisterController>().passwordController.text);
    if (user != null) {
      await UsersDatabase.createUser(
          newUserData: UserModel.createNewUser(
        fullName: Get.find<RegisterController>().fullNameController.text,
        emailAddress: Get.find<RegisterController>().emailController.text,
        password: Get.find<RegisterController>().passwordController.text,
        profileImageLink: "",
      ));
      Get.offAll(
        () => HomePage(),
        transition: Transition.cupertino,
        duration: 850.milliseconds,
      );
    }
  }

  Future<void> createNewUserProvider({required String providerName}) async {
    final resData = await AuthDatabase.createNewAccountProvider(providerName: providerName);
    if (resData != null) {
      await UsersDatabase.createUser(
        newUserData: UserModel.createNewUser(
            fullName: resData.user!.displayName.toString(),
            emailAddress: resData.user!.email.toString(),
            password: "",
            profileImageLink: resData.user!.photoURL!),
      );
      Get.offAll(
        () => HomePage(),
        transition: Transition.cupertino,
        duration: 850.milliseconds,
      );
    }
  }
}
