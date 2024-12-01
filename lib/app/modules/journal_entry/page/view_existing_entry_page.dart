import 'package:animate_do/animate_do.dart';
import 'package:emotijournal/app/models/journal_model.dart';
import 'package:emotijournal/app/modules/journal_entry/controller/journal_entry_controller.dart';
import 'package:emotijournal/app/modules/journal_entry/views/query_history_section.dart';
import 'package:emotijournal/app/modules/journal_entry/widget/animated_segmented_control.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewExistingEntryPage extends GetView<JournalManagementController> {
  final JournalModel selectedJournalEntry;

  const ViewExistingEntryPage({super.key, required this.selectedJournalEntry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 5.w,
        title: Text(
          selectedJournalEntry.title,
          maxLines: 2,
          textScaler: const TextScaler.linear(1),
          style: AppTextStyles.medium.copyWith(
            fontSize: 16.sp,
            color: AppColors.white,
          ),
        ),
        leading: CupertinoButton(
          onPressed: () {
            Get.back();
          },
          minSize: 0,
          padding: EdgeInsets.zero,
          pressedOpacity: 0.5,
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.white,
          ),
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FadeInUp(child: _buildQuotesList(context)),
                20.verticalSpace,
                FadeInUp(delay: 100.milliseconds, child: _buildQuotesPageIndicator(context)),
                20.verticalSpace,
                AnimatedSegmentedControl(
                  segments: const [
                    'Current Analysis',
                    'Previous Analysis',
                  ],
                  onSegmentSelected: (val) {
                    controller.selectedTabBarIndex.value = val;
                  },
                ),
                20.verticalSpace,
                AnimatedSwitcher(
                  duration: 850.milliseconds,
                  transitionBuilder: (child, transition) {
                    return FadeTransition(
                      opacity: transition,
                      child: child,
                    );
                  },
                  child: Obx(
                        () => controller.selectedTabBarIndex.value == 0
                        ? Column(
                      children: [
                        FadeInUp(delay: 200.milliseconds, child: _buildEmotionAnalysis(context)),
                        25.verticalSpace,
                        FadeInUp(delay: 300.milliseconds, child: _buildEmotionPillHeader(context)),
                        10.verticalSpace,
                        FadeInUp(delay: 400.milliseconds, child: _buildEmotionPillRow(context)),
                        20.verticalSpace,
                      ],
                    )
                        : QueryHistorySection(journal: selectedJournalEntry,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuotesList(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 250.h,
      child: PageView.builder(
        controller: controller.pageController,
        scrollDirection: Axis.horizontal,
        itemCount: selectedJournalEntry.quotesList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 28.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(
                color: AppColors.white,
                width: 1.0,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedJournalEntry.quotesList[index].quote,
                  textAlign: TextAlign.center,
                  textScaler: const TextScaler.linear(1),
                  style: AppTextStyles.light.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.white,
                  ),
                ),
                10.verticalSpace,
                SizedBox(
                  width: Get.width,
                  child: Text(
                    selectedJournalEntry.quotesList[index].author,
                    textAlign: TextAlign.end,
                    textScaler: const TextScaler.linear(1),
                    style: AppTextStyles.light.copyWith(
                      fontSize: 20.sp,
                      color: AppColors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuotesPageIndicator(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller.pageController,
      count: selectedJournalEntry.quotesList.length,
      effect: ScrollingDotsEffect(
        activeStrokeWidth: 2.6,
        activeDotScale: 1.3,
        activeDotColor: AppColors.white,
        maxVisibleDots: 5,
        radius: 8,
        spacing: 10,
        dotHeight: 12,
        dotColor: AppColors.white.withOpacity(0.5),
        dotWidth: 12,
      ),
    );
  }

  Widget _buildEmotionAnalysis(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 28.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(
          color: AppColors.white,
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Analysis',
            textScaler: const TextScaler.linear(1),
            style: AppTextStyles.medium.copyWith(
              fontSize: 20.sp,
              color: AppColors.white,
            ),
          ),
          12.verticalSpace,
          Text(
            selectedJournalEntry.queries.first.analysis,
            textAlign: TextAlign.start,
            textScaler: const TextScaler.linear(1),
            style: AppTextStyles.light.copyWith(
              fontSize: 16.sp,
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEmotionPillHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: SizedBox(
        width: Get.width,
        child: Text(
          'Current Emotions',
          textAlign: TextAlign.start,
          textScaler: const TextScaler.linear(1),
          style: AppTextStyles.medium.copyWith(
            fontSize: 20.sp,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildEmotionPillRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: SizedBox(
        width: Get.width,
        child: Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 5.w,
          runSpacing: 5.h,
          children: selectedJournalEntry.emotionsList.map((element) => _buildJournalMoodPill(context: context, pillText: element)).toList(),
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
              color: Colors.transparent,
              border: Border.all(
                color: AppColors.white,
                width: 1,
              )),
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
