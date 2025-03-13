import 'package:animate_do/animate_do.dart';
import 'package:emotijournal/app/common_widgets/custom_text_form_field.dart';
import 'package:emotijournal/app/modules/home/pages/home_page.dart';
import 'package:emotijournal/app/modules/journal_entry/controller/journal_entry_controller.dart';
import 'package:emotijournal/app/modules/journal_entry/dialogs/generating_response_dialog.dart';
import 'package:emotijournal/app/modules/journal_entry/views/query_history_section.dart';
import 'package:emotijournal/app/modules/journal_entry/widget/animated_segmented_control.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ResponseViewPage extends GetView<JournalManagementController> {
  const ResponseViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (val, _) {
        Get.offAll(() => HomePage(),
            transition: Transition.fade, duration: 850.milliseconds);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: Text(
            controller.generatedJournal.value.title,
            textScaler: const TextScaler.linear(1),
            style: AppTextStyles.medium.copyWith(
              fontSize: 20.sp,
              color: AppColors.white,
            ),
          ),
          leading: CupertinoButton(
            onPressed: () {
              Get.offAll(() => HomePage(),
                  transition: Transition.fade, duration: 850.milliseconds);
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FadeInUp(child: _buildQuotesList(context)),
                        20.verticalSpace,
                        FadeInUp(
                            delay: 100.milliseconds,
                            child: _buildQuotesPageIndicator(context)),
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
                                      FadeInUp(
                                          delay: 200.milliseconds,
                                          child:
                                              _buildEmotionAnalysis(context)),
                                      25.verticalSpace,
                                    ],
                                  )
                                : QueryHistorySection(
                                    journal: controller.generatedJournal.value,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  height: 110.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.r),
                    ),
                    color: AppColors.white,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: CustomizedTextFormField(
                          controller: controller.textController,
                          hintText: controller.isListening.isFalse
                              ? "Type Here"
                              : "Listening.",
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.black,
                          ),
                          suffixIcon: Assets.svgMicListeningOff,
                          onSuffixIconClicked: controller.handleUserInput,
                          suffixIconColor: AppColors.black,
                          verticalTextAlign: TextAlignVertical.center,
                          hintStyle: AppTextStyles.medium.copyWith(
                              fontSize: 14.sp,
                              color: AppColors.black
                                  .withAlpha((255 * 0.5).round())),
                          fillColor: Colors.transparent,
                          border: GradientOutlineInputBorder(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(25.r),
                            width: 1.0,
                          ),
                          focusedBorder: GradientOutlineInputBorder(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(25.r),
                            width: 2.0,
                          ),
                        ),
                      ),
                      28.horizontalSpace,
                      CupertinoButton(
                        onPressed: () async {
                          await Get.dialog(
                              Dialog(
                                backgroundColor: Colors.transparent,
                                child: GeneratingResponseDialog(
                                  completionFunction: () async {
                                    await controller.improveJournal();
                                  },
                                ),
                              ),
                              barrierDismissible: false,
                              barrierColor: AppColors.black
                                  .withAlpha((255 * 0.75).round()));
                        },
                        minSize: 0,
                        padding: EdgeInsets.zero,
                        pressedOpacity: 0.5,
                        child: Container(
                          width: 52.w,
                          height: 52.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.primaryGradient,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 14.h),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svgSendIcon,
                            ),
                          ),
                        ),
                      )
                    ],
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
        itemCount: controller.generatedJournal.value.quotesList.length,
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
                  controller.generatedJournal.value.quotesList[index].quote,
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
                    controller.generatedJournal.value.quotesList[index].author,
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
      count: controller.generatedJournal.value.quotesList.length,
      effect: ScrollingDotsEffect(
        activeStrokeWidth: 2.6,
        activeDotScale: 1.3,
        activeDotColor: AppColors.white,
        maxVisibleDots: 5,
        radius: 8,
        spacing: 10,
        dotHeight: 12,
        dotColor: AppColors.white.withAlpha((255 * 0.5).round()),
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
          _buildEmotionPieChartWidget(context),
          12.verticalSpace,
          Text(
            controller.generatedJournal.value.queries.last.analysis,
            textScaler: TextScaler.linear(1),
            style: AppTextStyles.light.copyWith(
              fontSize: 16.sp,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionPieChartWidget(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 200.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(int.parse(controller
                            .generatedJournal.value.emotionsList[index].colorHex
                            .replaceAll("#", "0xFF"))),
                      ),
                    ),
                    5.horizontalSpace,
                    Text(
                      controller
                          .generatedJournal.value.emotionsList[index].emotion,
                      textScaler: TextScaler.linear(1),
                      style: AppTextStyles.bold.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return 15.verticalSpace;
              },
              itemCount: controller.generatedJournal.value.emotionsList.length,
            ),
          ),
          15.horizontalSpace,
          Expanded(
            child: SizedBox(
              height: 200.h,
              child: PieChart(
                PieChartData(
                  sections: controller.generatedJournal.value.emotionsList
                      .map(
                        (element) => PieChartSectionData(
                          value: element.percentage.toDouble() / 100,
                          showTitle: true,
                          title: "${element.percentage}%",
                          titleStyle: AppTextStyles.black.copyWith(
                            fontSize: 16.sp,
                            color: AppColors.white,
                          ),
                          color: Color(int.parse(
                              element.colorHex.replaceAll("#", "0xFF"))),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
