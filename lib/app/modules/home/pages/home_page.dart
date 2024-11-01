import 'package:emotijournal/app/modules/home/controller/home_controller.dart';
import 'package:emotijournal/app/modules/home/widgets/custom_app_bar.dart';
import 'package:emotijournal/app/modules/home/widgets/custom_calendar_header_widget.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.darkBackgroundColor
          : AppColors.lightBackgroundColor,
      body: NestedScrollView(
        controller: controller.scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const CustomAppBar(),
          25.verticalSpace.sliverBox,
          const CustomCalendarHeaderWidget(),
          13.verticalSpace.sliverBox,
        ],
        body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 13.h),
          itemCount: 25,
          itemBuilder: (context, index) {
            return _buildJournalEntry(context, index);
          },
          separatorBuilder: (context, index) => 20.verticalSpace,
        ),
      ),
      floatingActionButton: CupertinoButton(
        onPressed: () {},
        minSize: 0,
        padding: EdgeInsets.zero,
        pressedOpacity: 0.5,
        child: Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: AppColors.primaryGradient.colors.map((element) => element.withOpacity(0.75)).toList(),
              stops: AppColors.primaryGradient.stops,
              begin: AppColors.primaryGradient.begin,
              end: AppColors.primaryGradient.end,
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              Assets.svgAddEntry,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJournalEntry(BuildContext context, int index) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: GradientBoxBorder(
          gradient: AppColors.primaryGradient,
          width: 2.w,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Test Title',
                textScaler: const TextScaler.linear(1),
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 20.sp,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkTextColor
                      : AppColors.lightTextColor,
                ),
              ),
              Text(
                DateFormat("hh:mm a").format(DateTime.now()),
                textScaler: const TextScaler.linear(1),
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 12.sp,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkTextColor.withOpacity(0.4)
                      : AppColors.lightTextColor.withOpacity(0.4),
                ),
              )
            ],
          ),
          5.verticalSpace,
          SizedBox(
            width: Get.width,
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer convallis mi cursus metus iaculis, non tempor ligula blandit. Ut bibendum elit quis augue tincidunt, eget vestibulum est mollis.",
              maxLines: 5,
              textScaler: const TextScaler.linear(1),
              style: AppTextStyles.normal.copyWith(
                fontSize: 14.sp,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkTextColor.withOpacity(0.75)
                    : AppColors.lightTextColor.withOpacity(0.75),
              ),
            ),
          ),
          20.verticalSpace,
          SizedBox(
            width: Get.width,
            child: Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 5.w,
              runSpacing: 5.h,
              children: [
                _buildJournalMoodPill(context, pillText: "Angry"),
                _buildJournalMoodPill(context, pillText: "Hate"),
                _buildJournalMoodPill(context, pillText: "Rage"),
                _buildJournalMoodPill(context, pillText: "Happiness"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildJournalMoodPill(
    BuildContext context, {
    required String pillText,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: AppColors.primaryGradient,
          ),
          child: Center(
            child: Text(
              pillText,
              softWrap: true,
              textScaler: const TextScaler.linear(1),
              style: AppTextStyles.semiBold.copyWith(
                fontSize: 14.sp,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
