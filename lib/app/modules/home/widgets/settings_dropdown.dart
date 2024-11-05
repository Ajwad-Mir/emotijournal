import 'package:emotijournal/app/modules/home/controller/home_controller.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

class SettingsDropdown extends GetView<HomeController> {
  const SettingsDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => Container(
            width: 180.w,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h),
              itemBuilder: (context, index) => CupertinoButton(
                onPressed: controller.optionsList[index].onPressed,
                minSize: 0,
                pressedOpacity: 0.5,
                padding: EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        controller.optionsList[index].icon,
                        width: 24.w,
                        height: 24.h,
                      ),
                      15.horizontalSpace,
                      Text(
                        controller.optionsList[index].text,
                        textScaler: const TextScaler.linear(1),
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 16.sp,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) {
                if (index != controller.optionsList.length - 1) {
                  return Divider(
                    color: AppColors.white.withOpacity(0.6),
                  );
                }
                return const SizedBox.shrink();
              },
              itemCount: controller.optionsList.length,
            ),
          ),
          onPop: () {
            Get.back();
          },
          direction: PopoverDirection.bottom,
          width: 180.w,
          arrowHeight: 15.h,
          arrowWidth: 15.w,
          arrowDyOffset: 10,
          transition: PopoverTransition.scale,
          radius: 10.r,
          barrierColor: Colors.black.withOpacity(0.5),
          barrierDismissible: true,
          backgroundColor: AppColors.primaryGradient.colors.first,
        );
      },
      minSize: 0,
      padding: EdgeInsets.zero,
      pressedOpacity: 0.5,
      child: SvgPicture.asset(Assets.svgSettings),
    );
  }
}
