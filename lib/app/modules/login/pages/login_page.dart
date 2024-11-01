import 'package:animate_do/animate_do.dart';
import 'package:emotijournal/app/modules/login/controller/login_controller.dart';
import 'package:emotijournal/app/modules/login/views/login_section.dart';
import 'package:emotijournal/app/modules/register/pages/register_page.dart';
import 'package:emotijournal/app/common_widgets/gradient_icons.dart';
import 'package:emotijournal/app/common_widgets/logo_widget.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) => Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkBackgroundColor
            : AppColors.lightBackgroundColor,
        body: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SafeArea(
            top: false,
            bottom: true,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    48.verticalSpace,
                    LogoWidget(
                      width: 95.5.w,
                      height: 114.6.h,
                    ),
                    15.verticalSpace,
                    _buildLoginIntroduction(context),
                    15.verticalSpace,
                    _buildLoginSection(context),
                    35.verticalSpace,
                    _buildAlternativeLoginOptions(context),
                    20.verticalSpace,
                    FadeInUp(
                      delay: 800.milliseconds,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have a account? ",
                            style: AppTextStyles.normal.copyWith(
                              fontSize: 16.sp,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppColors.darkTextColor
                                  : AppColors.lightTextColor,
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () {
                              Get.off(
                                () => const RegisterPage(),
                                transition: Transition.fade,
                                duration: 850.milliseconds,
                              );
                            },
                            minSize: 0,
                            pressedOpacity: 0.5,
                            padding: EdgeInsets.zero,
                            child: Text(
                              "Register!",
                              style: AppTextStyles.normal.copyWith(
                                fontSize: 16.sp,
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppColors.darkTextColor
                                    : AppColors.lightTextColor,
                                color: const Color(0xFF00DA89),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginIntroduction(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            delay: 100.milliseconds,
            child: Text(
              'Welcome to EmotiJournal',
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
            delay: 200.milliseconds,
            child: Text(
              'Your Safe Place to Discuss and Talk About Your Feelings',
              textScaler: const TextScaler.linear(1),
              style: AppTextStyles.normal.copyWith(
                  fontSize: 16.sp,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkTextColor.withOpacity(0.5)
                      : AppColors.lightTextColor.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginSection(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: const LoginSection(),
    );
  }

  Widget _buildAlternativeLoginOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FadeInUp(
          delay: 700.milliseconds,
          child: Text(
            'Or Login With',
            textScaler: const TextScaler.linear(1),
            style: AppTextStyles.normal.copyWith(
              fontSize: 14.sp,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkTextColor
                  : AppColors.lightTextColor,
            ),
          ),
        ),
        22.verticalSpace,
        FadeInUp(
          delay: 800.milliseconds,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPlatformButton(
                context: context,
                borderColor: Theme.of(context).brightness == Brightness.light
                    ? AppColors.darkBackgroundColor
                    : AppColors.lightBackgroundColor,
                icon: Assets.svgGoogleIcon,
              ),
              85.horizontalSpace,
              _buildPlatformButton(
                  context: context,
                  borderColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.darkBackgroundColor
                      : AppColors.lightBackgroundColor,
                  icon: Assets.svgAppleIcon)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPlatformButton(
      {required BuildContext context,
      required Color borderColor,
      required String icon}) {
    return CupertinoButton(
      onPressed: () {},
      pressedOpacity: 0.5,
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Container(
        width: 75.w,
        height: 75.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkBackgroundColor
              : AppColors.lightBackgroundColor,
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: GradientIconWithBorder(
          assetPath: icon,
          gradient: AppColors.primaryGradient,
        ),
      ),
    );
  }
}
