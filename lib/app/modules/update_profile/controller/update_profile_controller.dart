import 'dart:convert';

import 'package:emotijournal/app/database/users_database.dart';
import 'package:emotijournal/app/modules/journal_entry/dialogs/generating_response_dialog.dart';
import 'package:emotijournal/app/services/session_service.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  final isProcessing = false.obs;
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final Rx<XFile?> imageFile = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();

  void setImageFile(XFile file) {
    imageFile.value = file;
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 100,
      );
      if (image != null) {
        setImageFile(image);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updateExistingUser() async {
    await Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: GeneratingResponseDialog(
          completionFunction: () async {
            final image = await xFileToBase64(imageFile.value!);
            final updatedUser = Get.find<SessionService>().sessionUser.value.copyWith(
              fullName: fullNameController.text.isEmpty ? Get.find<SessionService>().sessionUser.value.fullName : fullNameController.text,
              emailAddress: emailController.text.isEmpty ? Get.find<SessionService>().sessionUser.value.emailAddress : emailController.text,
              password: passwordController.text.isEmpty ? Get.find<SessionService>().sessionUser.value.password : passwordController.text,
              profileImageLink: image,
            );
            UsersDatabase.updateUser(updatedUserData: updatedUser);
          },
          dialogText: "Updating Profile. Please wait",
        ),
      ),
      barrierDismissible: false,
      barrierColor: AppColors.black.withAlpha((255 * 0.5).round()),
    );

  }

  Future<String> xFileToBase64(XFile file) async {
    try {
      // Read the file as bytes
      final bytes = await file.readAsBytes();

      // Encode the bytes to Base64
      final base64String = base64Encode(bytes);

      return "data:image/png;base64,$base64String";
    } catch (e) {
      debugPrint("Error converting XFile to Base64: $e");
      return "";
    }
  }
}
