import 'dart:convert';

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
import 'package:http/http.dart' as http;

class SessionService extends GetxService {
  final sessionUser = UserModel.empty().obs;
  final userToken = ''.obs;

  Future<void> getUserFromToken() async {
    final token = GetStorage().read('userToken');
    if (token == null || token.toString().isEmpty) {
      Get.offAll(
        () => LoginPage(),
        transition: Transition.cupertino,
        duration: 850.milliseconds,
      );
      return;
    }
    userToken.value = token;
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
        final image = await networkImageToBase64(user.user!.photoURL.toString());
        await UsersDatabase.createUser(
          newUserData: UserModel.createNewUser(
            fullName: user.user!.displayName.toString(),
            emailAddress: user.user!.email.toString(),
            password: "",
            profileImageLink: image,
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
      final image = await networkImageToBase64(resData.user!.photoURL!);
      await UsersDatabase.createUser(
        newUserData: UserModel.createNewUser(
          fullName: resData.user!.displayName.toString(),
          emailAddress: resData.user!.email.toString(),
          password: "",
          profileImageLink: image,
        ),
      );
      Get.offAll(
        () => HomePage(),
        transition: Transition.cupertino,
        duration: 850.milliseconds,
      );
    }
  }

  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    return base64Encode(bytes);
  }
}
