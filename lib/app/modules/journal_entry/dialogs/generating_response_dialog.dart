import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class GeneratingResponseDialog extends StatefulWidget {
  final VoidCallback completionFunction;
  final String dialogText;

  const GeneratingResponseDialog(
      {super.key,
      required this.completionFunction,
      this.dialogText =
          'Thinking about how to respond to\nyour feelings. It can be hard\nsometimes but i know you are\ndoing what you can'});

  @override
  State<GeneratingResponseDialog> createState() =>
      _GeneratingResponseDialogState();
}

class _GeneratingResponseDialogState extends State<GeneratingResponseDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: AppColors.black.withAlpha((255 * 0.85).round())),
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 35.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            Assets.lottieJsonThinkingRobot,
            width: 210.w,
            height: 210.h,
          ),
          6.verticalSpace,
          Text(
            widget.dialogText,
            textScaler: const TextScaler.linear(1),
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBold.copyWith(
                fontSize: 16.sp,
                color: AppColors.white.withAlpha((255 * 0.85).round())),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(0.seconds, widget.completionFunction);
  }
}
