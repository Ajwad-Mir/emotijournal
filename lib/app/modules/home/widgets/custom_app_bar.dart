import 'package:emotijournal/app/modules/home/controller/home_controller.dart';
import 'package:emotijournal/app/modules/home/widgets/settings_dropdown.dart';
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
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverAppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkBackgroundColor
            : AppColors.lightBackgroundColor,
        surfaceTintColor: Colors.transparent,
        expandedHeight: 250.0.h,
        collapsedHeight: 100.0.h,
        toolbarHeight: 80.h,
        floating: false,
        pinned: true,
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: const SettingsDropdown(),
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
                crossFadeState: controller.isCollapsed.value
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,

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
        border: const GradientBoxBorder(
            gradient: AppColors.primaryGradient, width: 1.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 75.0.w,
            height: 75.0.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  Assets.pngProfilePicture,
                ),
              ),
            ),
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
                    'Ajwad Mir',
                    style: AppTextStyles.medium.copyWith(
                        fontSize: 24.0.sp,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkTextColor
                            : AppColors.lightTextColor),
                  ),
                  CupertinoButton(
                    onPressed: () {},
                    minSize: 0,
                    padding: EdgeInsets.zero,
                    pressedOpacity: 0.5,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.svgEditUser,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.darkTextColor
                                : AppColors.lightTextColor,
                            BlendMode.srcIn,
                          ),
                          width: 20.w,
                          height: 17.h,
                        ),
                        10.horizontalSpace,
                        Text(
                          'Edit your profile',
                          style: AppTextStyles.normal.copyWith(
                            fontSize: 18.sp,
                            decoration: TextDecoration.underline,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.darkTextColor
                                    : AppColors.lightTextColor,
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
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkBackgroundColor
              : AppColors.lightBackgroundColor,
          border: const GradientBoxBorder(
              gradient: AppColors.primaryGradient, width: 1.0),
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.white.withOpacity(0.15)
                  : AppColors.black.withOpacity(0.15),
              blurRadius: 4,
              blurStyle: BlurStyle.normal,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40.0.w,
                height: 40.0.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.pngProfilePicture,
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              Text(
                'Ajwad Mir',
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
          CupertinoButton(
            onPressed: () {},
            minSize: 0,
            padding: EdgeInsets.zero,
            pressedOpacity: 0.5,
            child: SvgPicture.asset(
              Assets.svgEditUser,
              colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.dark
                    ? AppColors.white
                    : AppColors.black,
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
