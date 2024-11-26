import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NoNotesWidget extends StatelessWidget {
  const NoNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Theme.of(context).brightness == Brightness.dark ? Assets.svgNoNotesLight : Assets.svgNoNotesDark,
            width: 200.w,
          ),
          10.verticalSpace,
          SizedBox(
            width: Get.width * 0.65,
            child: Text(
              "Your mental journal is ready, but today's emotions are on pause. Start fresh with a thought, a dream, or just a moment.",
              textScaler: TextScaler.linear(1),
              textAlign: TextAlign.center,
              style: AppTextStyles.medium.copyWith(
                fontSize: 14.sp,
                color: (Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor).withAlpha((0.5 * 255).round()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
