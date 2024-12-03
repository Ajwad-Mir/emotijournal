import 'package:emotijournal/app/common_widgets/cached_memory_image_widget.dart';
import 'package:emotijournal/app/modules/home/controller/home_controller.dart';
import 'package:emotijournal/app/modules/settings/page/settings_page.dart';
import 'package:emotijournal/app/modules/update_profile/pages/update_profile_page.dart';
import 'package:emotijournal/app/services/session_service.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CustomAppBar extends GetView<HomeController> {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverAppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.darkBackgroundColor : AppColors.lightBackgroundColor,
        surfaceTintColor: Colors.transparent,
        expandedHeight: 250.0.h,
        collapsedHeight: 100.0.h,
        toolbarHeight: 85.h,
        floating: false,
        pinned: true,
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: CupertinoButton(
              onPressed: () {
                Get.to(
                  () => SettingsPage(),
                  transition: Transition.fade,
                  duration: 850.milliseconds,
                );
              },
              minSize: 0,
              padding: EdgeInsets.zero,
              pressedOpacity: 0.5,
              child: SvgPicture.asset(Assets.svgSettings),
            ),
          ),
        ],
        title: controller.isCollapsed.value
            ? _buildCollapsedSection(context)
            : GradientText(
                "EmotiJournal",
                style: AppTextStyles.normal.copyWith(
                  fontSize: 28.sp,
                ),
                textScaleFactor: 1,
                gradientType: GradientType.linear,
                gradientDirection: GradientDirection.ttb,
                colors: AppColors.primaryGradient.colors,
              ),
        titleSpacing: 28.w,
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: const [StretchMode.fadeTitle],
          background: Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: Center(
              child: AnimatedCrossFade(
                firstChild: _buildExpandedSection(context),
                secondChild: Container(),
                // Empty container when collapsed
                crossFadeState: controller.isCollapsed.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,

                duration: const Duration(milliseconds: 750),
                reverseDuration: const Duration(milliseconds: 750),
                firstCurve: Curves.easeIn,
                secondCurve: Curves.easeOut,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedSection(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(left: 28.w, right: 28.w, top: 25.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 40.0.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: const GradientBoxBorder(gradient: AppColors.primaryGradient, width: 1.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Get.find<SessionService>().sessionUser.value.profileImageLink.isEmpty
              ? Container(
                  width: 70.w,
                  height: 70.h,
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    Assets.svgUserProfile,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.contain,
                  ),
                )
              : CachedBase64Image(
                  base64String: Get.find<SessionService>().sessionUser.value.profileImageLink,
                  width: 70.w,
                  height: 70.h,
                ),
          20.horizontalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: SizedBox(
              height: 75.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    Get.find<SessionService>().sessionUser.value.fullName,
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 24.0.sp,
                        color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      Get.to(
                        () => UpdateProfilePage(),
                        transition: Transition.fade,
                        duration: 850.milliseconds,
                      );
                    },
                    minSize: 0,
                    padding: EdgeInsets.zero,
                    pressedOpacity: 0.5,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.svgEditUser,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
                            BlendMode.srcIn,
                          ),
                          width: 20.w,
                          height: 17.h,
                        ),
                        10.horizontalSpace,
                        Text(
                          'Edit your profile',
                          textScaler: TextScaler.linear(1),
                          style: AppTextStyles.normal.copyWith(
                            fontSize: 18.sp,
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCollapsedSection(BuildContext context) {
    return Container(
      width: 300.w,
      height: 65.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: const GradientBoxBorder(gradient: AppColors.primaryGradient, width: 1.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Get.find<SessionService>().sessionUser.value.profileImageLink.isEmpty
                  ? Container(
                      width: 40.w,
                      height: 40.h,
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        Assets.svgUserProfile,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black,
                          BlendMode.srcIn,
                        ),
                        fit: BoxFit.contain,
                      ),
                    )
                  : CachedBase64Image(base64String: Get.find<SessionService>().sessionUser.value.profileImageLink),
              12.horizontalSpace,
              Text(
                Get.find<SessionService>().sessionUser.value.fullName,
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          CupertinoButton(
            onPressed: () {
              Get.to(
                () => UpdateProfilePage(),
                transition: Transition.fade,
                duration: 850.milliseconds,
              );
            },
            minSize: 0,
            padding: EdgeInsets.zero,
            pressedOpacity: 0.5,
            child: SvgPicture.asset(
              Assets.svgEditUser,
              colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black,
                BlendMode.srcIn,
              ),
              width: 20.w,
              height: 17.h,
            ),
          )
        ],
      ),
    );
  }
}
