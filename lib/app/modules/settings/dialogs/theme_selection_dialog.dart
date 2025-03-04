import 'package:emotijournal/app/services/theme_service.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ThemeSelectionDialog extends StatelessWidget {
  const ThemeSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 150.w,
        decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(15.r)),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Theme',
              textScaler: const TextScaler.linear(1),
              style: AppTextStyles.medium.copyWith(
                fontSize: 16.sp,
                color: AppColors.white,
              ),
            ),
            11.verticalSpace,
            Text(
              'Choose a theme that suits your preference.',
              textScaler: const TextScaler.linear(1),
              style: AppTextStyles.medium.copyWith(
                fontSize: 12.sp,
                color: AppColors.white.withAlpha(50),
              ),
            ),
            50.verticalSpace,
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => CupertinoButton(
                onPressed: () {
                  Get.find<ThemeService>().changeTheme(ThemeMode.values[index]);
                  Get.back();
                },
                minSize: 0,
                padding: EdgeInsets.zero,
                pressedOpacity: 0.5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              ThemeMode.values[index].name == 'dark'
                                  ? Assets.svgDarkTheme
                                  : ThemeMode.values[index].name == 'light'
                                      ? Assets.svgLightTheme
                                      : Assets.svgSystemTheme,
                              width: 24.w,
                              height: 24.h,
                            ),
                            15.horizontalSpace,
                            Text(
                              ThemeMode.values[index].name,
                              textScaler: const TextScaler.linear(1),
                              style: AppTextStyles.normal.copyWith(
                                  fontSize: 16.sp, color: AppColors.white),
                            ),
                          ],
                        ),
                        if (Get.find<ThemeService>().currentThemeMode.value ==
                            ThemeMode.values[index])
                          SvgPicture.asset(
                            Assets.svgSelectedOption,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => Divider(
                color: AppColors.white.withAlpha(50),
              ),
              itemCount: ThemeMode.values.length,
            )
          ],
        ),
      ),
    );
  }
}
