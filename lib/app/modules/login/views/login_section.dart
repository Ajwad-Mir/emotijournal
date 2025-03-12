import 'package:animate_do/animate_do.dart';
import 'package:emotijournal/app/modules/login/controller/login_controller.dart';
import 'package:emotijournal/app/common_widgets/custom_text_form_field.dart';
import 'package:emotijournal/app/common_widgets/gradient_checkbox.dart';
import 'package:emotijournal/app/services/session_service.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class LoginSection extends GetView<LoginController> {
  const LoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInUp(
          delay: 300.milliseconds,
          child: Text(
            'Login',
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
              key: controller.loginFormKey,
              child: Column(
                children: [
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
                          ? AppColors.darkTextColor.withAlpha(50)
                          : AppColors.lightTextColor.withAlpha(50),
                    ),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Email address should not be empty";
                      } else if (value.toString().isEmail == false) {
                        return "This is not a email address";
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
                          ? AppColors.darkTextColor.withAlpha(50)
                          : AppColors.lightTextColor.withAlpha(50),
                    ),
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Password should not be empty";
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
                  15.verticalSpace,
                  _buildLoginOptions(context),
                  37.verticalSpace,
                  _buildLoginButton(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginOptions(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GradientCheckbox(
            isChecked: controller.isRemembered.value,
            gradient: AppColors.primaryGradient,
            checkBoxText: 'Remember Me',
            checkBoxTextStyle: AppTextStyles.normal.copyWith(
              fontSize: 14.sp,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkTextColor
                  : AppColors.lightTextColor,
            ),
            size: 25.w,
            radius: 5.r,
            onPressed: () {
              controller.isRemembered.value = !controller.isRemembered.value;
              controller.update();
            },
          ),
          CupertinoButton(
            onPressed: () {},
            minSize: 0,
            padding: EdgeInsets.zero,
            pressedOpacity: 0.5,
            child: Text(
              'Forgot Password?',
              textScaler: const TextScaler.linear(1),
              style: AppTextStyles.normal.copyWith(
                fontSize: 14.sp,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkTextColor
                    : AppColors.lightTextColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return CupertinoButton(
      onPressed: () async {
        if (controller.loginFormKey.currentState!.validate()) {
          await Get.find<SessionService>().loginExistingSimple();
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
                    'Login',
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
