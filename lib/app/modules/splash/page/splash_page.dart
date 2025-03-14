import 'package:emotijournal/app/common_widgets/logo_widget.dart';
import 'package:emotijournal/app/modules/splash/controller/splash_controller.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (_) => Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkBackgroundColor
            : AppColors.lightBackgroundColor,
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: SafeArea(
            child: _buildAppLogoWidget(context)
          ),
        ),
      ),
    );
  }

  Widget _buildAppLogoWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LogoWidget(
          width: 214.67.w,
          height: 257.6.h,
        ),
        54.4.verticalSpace,
        GradientText(
          "EmotiJournal",
          style: AppTextStyles.normal.copyWith(
            fontSize: 38.sp,
          ),
          gradientType: GradientType.linear,
          gradientDirection: GradientDirection.ttb,
          colors: AppColors.primaryGradient.colors,
        ),
      ],
    );
  }
}
