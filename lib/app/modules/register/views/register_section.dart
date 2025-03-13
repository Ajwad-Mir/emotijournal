import 'package:animate_do/animate_do.dart';
import 'package:emotijournal/app/common_widgets/custom_text_form_field.dart';
import 'package:emotijournal/app/modules/register/controller/register_controller.dart';
import 'package:emotijournal/app/services/session_service.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class RegisterSection extends GetView<RegisterController> {
  const RegisterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInUp(
          delay: 300.milliseconds,
          child: Text(
            'Register',
            textScaler: const TextScaler.linear(1),
            style: AppTextStyles.semiBold.copyWith(
                fontSize: 24.sp,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkTextColor
                    : AppColors.lightTextColor),
          ),
        ),
        10.verticalSpace,
        FadeInUp(
          delay: 600.milliseconds,
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
            decoration: BoxDecoration(
              border: GradientBoxBorder(
                  gradient: AppColors.primaryGradient, width: 1.w),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Form(
              key: controller.registerFormKey,
              child: Column(
                children: [
                  CustomizedTextFormField(
                    controller: controller.fullNameController,
                    style: AppTextStyles.normal.copyWith(
                      fontSize: 14.sp,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkTextColor
                          : AppColors.lightTextColor,
                    ),
                    hintText: 'Full Name',
                    hintStyle: AppTextStyles.normal.copyWith(
                      fontSize: 14.sp,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkTextColor.withAlpha((255 * 0.5).round())
                          : AppColors.lightTextColor.withAlpha((255 * 0.5).round()),
                    ),
                    validator: (val) {
                      if (val.toString().isEmpty) {
                        return 'Full name is required';
                      } else if (!RegExp(r'^[a-zA-Z]+(\s[a-zA-Z]+){1,2}$')
                          .hasMatch(val.toString())) {
                        return 'Please enter a valid full name (First, Middle, and Last name are allowed)';
                      }
                      return null;
                    },
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.darkBackgroundColor
                        : AppColors.lightBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.white
                              : AppColors.black,
                          width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.white
                              : AppColors.black,
                          width: 1.5),
                    ),
                  ),
                  21.verticalSpace,
                  CustomizedTextFormField(
                    controller: controller.emailController,
                    style: AppTextStyles.normal.copyWith(
                      fontSize: 14.sp,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkTextColor
                          : AppColors.lightTextColor,
                    ),
                    hintText: 'Email Address',
                    hintStyle: AppTextStyles.normal.copyWith(
                      fontSize: 14.sp,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkTextColor.withAlpha((255 * 0.5).round())
                          : AppColors.lightTextColor.withAlpha((255 * 0.5).round()),
                    ),
                    validator: (val) {
                      if (val.toString().isEmpty) {
                        return "Email cannot be empty";
                      } else if (val.toString().isNotEmpty &&
                          !val.toString().isEmail) {
                        return "This is a invalid email address";
                      }
                      return null;
                    },
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.darkBackgroundColor
                        : AppColors.lightBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.white
                              : AppColors.black,
                          width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.white
                              : AppColors.black,
                          width: 1.5),
                    ),
                  ),
                  21.verticalSpace,
                  CustomizedTextFormField(
                    controller: controller.passwordController,
                    style: AppTextStyles.normal.copyWith(
                      fontSize: 14.sp,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkTextColor
                          : AppColors.lightTextColor,
                    ),
                    hintText: 'Password',
                    hintStyle: AppTextStyles.normal.copyWith(
                      fontSize: 14.sp,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkTextColor.withAlpha((255 * 0.5).round())
                          : AppColors.lightTextColor.withAlpha((255 * 0.5).round()),
                    ),
                    validator: (val) {
                      if (val.toString().isEmpty) {
                        return "Password cannot be empty";
                      } else if (val.toString() !=
                          controller.confirmPasswordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.darkBackgroundColor
                        : AppColors.lightBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.white
                              : AppColors.black,
                          width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.white
                              : AppColors.black,
                          width: 1.5),
                    ),
                  ),
                  21.verticalSpace,
                  CustomizedTextFormField(
                    controller: controller.confirmPasswordController,
                    style: AppTextStyles.normal.copyWith(
                      fontSize: 14.sp,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkTextColor
                          : AppColors.lightTextColor,
                    ),
                    hintText: 'Confirm Password',
                    validator: (val) {
                      if (val.toString().isEmpty) {
                        return "Password cannot be empty";
                      } else if (val.toString() !=
                          controller.passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    hintStyle: AppTextStyles.normal.copyWith(
                      fontSize: 14.sp,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkTextColor.withAlpha((255 * 0.5).round())
                          : AppColors.lightTextColor.withAlpha((255 * 0.5).round()),
                    ),
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.darkBackgroundColor
                        : AppColors.lightBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.white
                              : AppColors.black,
                          width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.white
                              : AppColors.black,
                          width: 1.5),
                    ),
                  ),
                  37.verticalSpace,
                  _buildRegisterButton(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return CupertinoButton(
      onPressed: () async {
        if (controller.registerFormKey.currentState!.validate()) {
          await Get.find<SessionService>().createNewUserSimple();
        }
      },
      minSize: 0,
      pressedOpacity: 0.5,
      padding: EdgeInsets.zero,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.white
                : AppColors.black,
            width: 1.0.w,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Obx(
          () => Get.find<SessionService>().isProcessing.isTrue
              ? Center(
                child: SizedBox(
                    width: 16.sp, // Same as text size
                    height: 16.sp,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2,
                    ),
                  ),
              )
              : Center(
                  child: Text(
                    'Register',
                    textScaler: const TextScaler.linear(1),
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 16.sp,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkTextColor
                          : AppColors.lightTextColor,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
