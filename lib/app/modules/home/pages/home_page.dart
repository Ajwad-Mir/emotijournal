import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:emotijournal/app/modules/home/controller/home_controller.dart';
import 'package:emotijournal/app/modules/home/widgets/custom_app_bar.dart';
import 'package:emotijournal/app/modules/home/widgets/custom_calendar_header_widget.dart';
import 'package:emotijournal/app/modules/home/widgets/no_notes_widget.dart';
import 'package:emotijournal/app/modules/journal_entry/page/create_new_entry_page.dart';
import 'package:emotijournal/app/modules/journal_entry/page/view_existing_entry_page.dart';
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
import 'package:shimmer/shimmer.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      initState: (_) async {
        await controller.getAllJournalEntries();
      },
      builder: (_) => Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? AppColors.darkBackgroundColor : AppColors.lightBackgroundColor,
        body: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            const CustomAppBar(),
            SliverToBoxAdapter(
              child: 25.verticalSpace,
            ),
            const CustomCalendarHeaderWidget(),
            SliverToBoxAdapter(
              child: 15.verticalSpace,
            ),
            _buildJournalList(context),
          ],
        ),
        floatingActionButton: CupertinoButton(
          onPressed: () {
            Get.to(
              () => const CreateNewEntryPage(),
              transition: Transition.fade,
              duration: 850.milliseconds,
            );
          },
          minSize: 0,
          padding: EdgeInsets.zero,
          pressedOpacity: 0.5,
          child: Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black,
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: SvgPicture.asset(
              Assets.svgAddEntry,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJournalList(BuildContext context) {
    if (controller.isLoading.isFalse && controller.journalList.isEmpty) {
      return SliverFillRemaining(child: NoNotesWidget());
    }
    return SliverList.separated(
      itemCount: controller.isLoading.isTrue ? 5 : controller.journalList.length,
      itemBuilder: (context, index) {
        if (controller.isLoading.isTrue) {
          return Shimmer.fromColors(
            baseColor: (Theme.of(context).brightness == Brightness.light ? AppColors.white : AppColors.black).withOpacity(0.2),
            highlightColor: (Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black).withOpacity(0.4),
            direction: ShimmerDirection.ltr,
            period: 850.milliseconds,
            child: Container(
              width: Get.width,
              height: 250.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: GradientBoxBorder(
                    gradient: AppColors.primaryGradient,
                    width: 2.w,
                  ),
                  color: AppColors.white),
            ),
          );
        }
        return FadeInUp(
          delay: 100.milliseconds,
          duration: 500.milliseconds,
          child: _buildJournalEntry(context, index),
        );
      },
      separatorBuilder: (context, index) => 20.verticalSpace,
    );
  }

  Widget _buildJournalEntry(BuildContext context, int index) {
    return CupertinoButton(
      onPressed: () {
        log(controller.journalList[index].quotesList.length.toString());
        Get.to(
          () => ViewExistingEntryPage(
            selectedJournalEntry: controller.journalList[index],
          ),
          transition: Transition.fade,
          duration: 850.milliseconds,
        );
      },
      minSize: 0,
      pressedOpacity: 0.5,
      padding: EdgeInsets.zero,
      child: Container(
        width: Get.width,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    controller.journalList[index].title,
                    textScaler: const TextScaler.linear(1),
                    style: AppTextStyles.semiBold.copyWith(
                      fontSize: 20.sp,
                      color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
                    ),
                  ),
                ),
                20.horizontalSpace,
                Text(
                  DateFormat("hh:mm a").format(
                    controller.journalList[index].createdAt,
                  ),
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
            15.verticalSpace,
            SizedBox(
              width: Get.width,
              child: Text(
                controller.journalList[index].queries.first.query,
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
                children:
                    controller.journalList[index].emotionsList.map((element) => _buildJournalMoodPill(context: context, pillText: element)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildJournalMoodPill({required BuildContext context, required String pillText}) {
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
