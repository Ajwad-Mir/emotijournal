import 'package:emotijournal/app/modules/settings/dialogs/theme_selection_dialog.dart';
import 'package:emotijournal/app/modules/login/pages/login_page.dart';
import 'package:emotijournal/app/modules/settings/controller/settings_controller.dart';
import 'package:emotijournal/app/modules/subscriptions/pages/subscription_page.dart';
import 'package:emotijournal/app/services/auth_providers/google_auth_provider_services.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.darkBackgroundColor : AppColors.lightBackgroundColor,
      appBar: AppBar(
        systemOverlayStyle: Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle(
                systemNavigationBarColor: Colors.black.withAlpha(1),
                systemNavigationBarIconBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light,
                //Android Icons
                statusBarBrightness: Brightness.dark,
                //iOS Icons
                statusBarColor: Colors.black.withAlpha(1),
              )
            : SystemUiOverlayStyle(
                systemNavigationBarColor: Colors.white.withAlpha(1),
                systemNavigationBarIconBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
                //Android Icons
                statusBarBrightness: Brightness.light,
                //iOS Icons
                statusBarColor: Colors.black.withAlpha(1),
              ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: GradientText(
          "EmotiJournal",
          style: AppTextStyles.normal.copyWith(
            fontSize: 28.sp,
          ),
          textScaleFactor: 1,
          gradientType: GradientType.linear,
          gradientDirection: GradientDirection.ttb,
          colors: AppColors.primaryGradient.colors,
        ),
        leading: CupertinoButton(
          onPressed: () {
            Get.back();
          },
          minSize: 0,
          pressedOpacity: 0.5,
          padding: EdgeInsets.zero,
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black,
          ),
        ),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SafeArea(
          top: false,
          bottom: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCard(context),
                _buildAccountOptions(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        Text(
          "Settings",
          textScaler: TextScaler.linear(1),
          style: AppTextStyles.normal.copyWith(
            fontSize: 28.sp,
            color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
          ),
        ),
        35.verticalSpace,
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              gradient: AppColors.primaryGradient,
            ),
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: Column(
            children: [
              _buildCustomListTile(
                context: context,
                onPressed: () {
                  showDialog(context: context, builder: (context) => ThemeSelectionDialog());
                },
                title: "Theme Mode",
                leadingSvgIcon: SvgPicture.asset(
                  Assets.svgThemeSelection,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              30.verticalSpace,
              _buildCustomListTile(
                context: context,
                onPressed: () {
                  Get.to(
                    () => SubscriptionPage(),
                    transition: Transition.fadeIn,
                    duration: 850.milliseconds,
                  );
                },
                title: "Manage Subscription",
                leadingSvgIcon: SvgPicture.asset(
                  Assets.svgSubscriptions,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCustomListTile({required BuildContext context, required String title, required SvgPicture leadingSvgIcon, required VoidCallback onPressed}) {
    return CupertinoButton(
      onPressed: onPressed,
      minSize: 0,
      padding: EdgeInsets.zero,
      pressedOpacity: 0.5,
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                leadingSvgIcon,
                30.horizontalSpace,
                Text(
                  title,
                  textScaler: TextScaler.linear(1),
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 18.sp,
                    color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
                  ),
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAccountOptions(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoButton(
          onPressed: () async {
            await GoogleAuthProviderService().logout();
            Get.offAll(
              () => LoginPage(),
              transition: Transition.fadeIn,
              duration: 850.milliseconds,
            );
          },
          minSize: 0,
          padding: EdgeInsets.zero,
          pressedOpacity: 0.5,
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black,
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.svgLogout,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
                17.horizontalSpace,
                Text(
                  "Logout",
                  textScaler: TextScaler.linear(1),
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 18.sp,
                    color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
                  ),
                )
              ],
            ),
          ),
        ),
        20.verticalSpace,
        CupertinoButton(
          onPressed: () async {
            await GoogleAuthProviderService().logout();
            Get.offAll(
              () => LoginPage(),
              transition: Transition.fade,
              duration: 850.milliseconds,
            );
          },
          minSize: 0,
          padding: EdgeInsets.zero,
          pressedOpacity: 0.5,
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.red,
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
            ),
            child: Center(
              child: Text(
                "Delete Account",
                textScaler: TextScaler.linear(1),
                style: AppTextStyles.medium.copyWith(
                  fontSize: 18.sp,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
        20.verticalSpace,
      ],
    );
  }
}
