import 'package:animate_do/animate_do.dart';
import 'package:emotijournal/app/common_widgets/custom_text_form_field.dart';
import 'package:emotijournal/app/modules/update_profile/controller/update_profile_controller.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UpdateProfileSection extends GetView<UpdateProfileController> {
  const UpdateProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: 600.milliseconds,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white.withAlpha(70), width: 4.w),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          children: [
            CustomizedTextFormField(
              controller: controller.fullNameController,
              style: AppTextStyles.normal.copyWith(
                fontSize: 14.sp,
                color: AppColors.white,
              ),
              hintStyle: AppTextStyles.normal.copyWith(
                fontSize: 14.sp,
                color: AppColors.white.withAlpha((255 * .75).round()),
              ),
              hintText: 'Full Name',
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.white, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.white, width: 2.5),
              ),
            ),
            21.verticalSpace,
            CustomizedTextFormField(
              controller: controller.emailController,
              style: AppTextStyles.normal.copyWith(
                fontSize: 14.sp,
                color: AppColors.white,
              ),
              hintStyle: AppTextStyles.normal.copyWith(
                fontSize: 14.sp,
                color: AppColors.white.withAlpha((255 * .75).round()),
              ),
              hintText: 'Email Address',
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.white, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.white, width: 2.5),
              ),
            ),
            21.verticalSpace,
            CustomizedTextFormField(
              controller: controller.passwordController,
              style: AppTextStyles.normal.copyWith(
                fontSize: 14.sp,
                color: AppColors.white,
              ),
              hintStyle: AppTextStyles.normal.copyWith(
                fontSize: 14.sp,
                color: AppColors.white.withAlpha((255 * .75).round()),
              ),
              hintText: 'Password',
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.white, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.white, width: 2.5),
              ),
            ),
            21.verticalSpace,
            CustomizedTextFormField(
              controller: controller.confirmPasswordController,
              style: AppTextStyles.normal.copyWith(
                fontSize: 14.sp,
                color: AppColors.white,
              ),
              hintStyle: AppTextStyles.normal.copyWith(
                fontSize: 14.sp,
                color: AppColors.white.withAlpha((255 * .75).round()),
              ),
              hintText: 'Confirm Password',
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.white, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.white, width: 2.5),
              ),
            ),
            37.verticalSpace,
            _buildUpdateButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return CupertinoButton(
      onPressed: () async {
        controller.isProcessing.value = true;
        await Get.find<UpdateProfileController>().updateExistingUser();
        controller.isProcessing.value = false;
      },
      minSize: 0,
      pressedOpacity: 0.5,
      padding: EdgeInsets.zero,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            color: AppColors.white,
            width: 2.0.w,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Center(
          child: Obx(
            () => controller.isProcessing.isTrue ? SizedBox(
              width: 16.sp, // Same as text size
              height: 16.sp,
              child: CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 2,
              ),
            ) : Text(
              'Update',
              textScaler: const TextScaler.linear(1),
              style: AppTextStyles.normal.copyWith(
                fontSize: 16.sp,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
