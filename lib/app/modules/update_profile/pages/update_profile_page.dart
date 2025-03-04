import 'dart:convert';
import 'dart:io';

import 'package:emotijournal/app/modules/update_profile/controller/update_profile_controller.dart';
import 'package:emotijournal/app/modules/update_profile/dialogs/image_selection_dialog.dart';
import 'package:emotijournal/app/modules/update_profile/view/update_profile_section.dart';
import 'package:emotijournal/app/services/session_service.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UpdateProfilePage extends GetView<UpdateProfileController> {
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateProfileController>(
      builder: (_) => Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: Text(
            'Update Profile',
            textScaler: const TextScaler.linear(1),
            style: AppTextStyles.medium.copyWith(
              fontSize: 20.sp,
              color: AppColors.white,
            ),
          ),
          leading: CupertinoButton(
            onPressed: () {
              Get.back();
            },
            minSize: 0,
            padding: EdgeInsets.zero,
            pressedOpacity: 0.5,
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.white,
            ),
          ),
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SafeArea(
            top: true,
            bottom: true,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildProfileImageSection(context),
                    50.verticalSpace,
                    _buildUpdateProfileSection(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImageSection(BuildContext context) {
    return Obx(() {
      if (Get.find<SessionService>().sessionUser.value.profileImageLink.isEmpty) {
        return Container(
          width: 160.w,
          height: 160.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1.0.w,
              color: AppColors.white,
            ),
            color: AppColors.black.withAlpha(76),
          ),
          clipBehavior: Clip.none,
          child: Center(
            child: SvgPicture.asset(
              Assets.svgUserProfile,
              width: 65.w,
            ),
          ),
        );
      } else {
        if (controller.imageFile.value == null) {
          return Container(
            width: 160.w,
            height: 160.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.0.w,
                color: AppColors.white,
              ),
              color: AppColors.black.withAlpha(76),
              image: DecorationImage(
                image: MemoryImage(base64Decode(Get.find<SessionService>().sessionUser.value.profileImageLink.split(",").last)),
                fit: BoxFit.cover,
              ),
            ),
            clipBehavior: Clip.none,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: -10.h,
                  right: 0,
                  child: CupertinoButton(
                    onPressed: () async {
                      await Get.dialog(
                        Dialog(
                          child: ImageSelectionWidget(),
                        ),
                        barrierDismissible: false,
                        barrierColor: AppColors.black.withAlpha(75),
                      );
                    },
                    minSize: 0,
                    padding: EdgeInsets.zero,
                    child: Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: AppColors.black.withAlpha(76),
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.0.w,
                          color: AppColors.white,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svgAddImage,
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(
            width: 160.w,
            height: 160.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.0.w,
                color: AppColors.white,
              ),
              color: AppColors.black.withAlpha(76),
              image: DecorationImage(
                image: FileImage(File(controller.imageFile.value!.path)),
                fit: BoxFit.cover,
              ),
            ),
            clipBehavior: Clip.none,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: -10.h,
                  right: 0,
                  child: CupertinoButton(
                    onPressed: () async {
                      await Get.dialog(
                        Dialog(
                          child: ImageSelectionWidget(),
                        ),
                        barrierDismissible: false,
                        barrierColor: AppColors.black.withAlpha(75),
                      );
                    },
                    minSize: 0,
                    padding: EdgeInsets.zero,
                    child: Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: AppColors.black.withAlpha(76),
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.0.w,
                          color: AppColors.white,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svgAddImage,
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      }
    });
  }

  Widget _buildUpdateProfileSection(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: const UpdateProfileSection(),
    );
  }
}
