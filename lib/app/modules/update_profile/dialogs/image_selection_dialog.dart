import 'package:emotijournal/app/modules/update_profile/controller/update_profile_controller.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionWidget extends StatelessWidget {
  const ImageSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
            onPressed: () {
              Get.back();
              Get.find<UpdateProfileController>().pickImage(ImageSource.camera);
            },
            minSize: 0,
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.svgCamera,
                ),
                15.horizontalSpace,
                Text(
                  'Camera',
                  textScaler: TextScaler.linear(1),
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          10.verticalSpace,
          Divider(
            color: AppColors.white,
            thickness: 1.w,
          ),
          10.verticalSpace,
          CupertinoButton(
            onPressed: () {
              Get.back();
              Get.find<UpdateProfileController>().pickImage(ImageSource.gallery);
            },
            minSize: 0,
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.svgGallery,
                ),
                15.horizontalSpace,
                Text(
                  'Gallery',
                  textScaler: TextScaler.linear(1),
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
