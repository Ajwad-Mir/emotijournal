import 'package:emotijournal/app/common_widgets/custom_text_form_field.dart';
import 'package:emotijournal/app/modules/journal_entry/dialogs/generating_response_dialog.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ResponseViewPage extends StatelessWidget {
  final pageController = PageController();
  final textController = TextEditingController();

  ResponseViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Title Text',
          textScaler: const TextScaler.linear(1),
          style: AppTextStyles.medium.copyWith(
            fontSize: 20.sp,
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
      bottomNavigationBar: Container(
        width: Get.width,
        height: 90.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.r),
          ),
          color: AppColors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 28.w,vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: CustomizedTextFormField(
                controller: textController,
                hintText: 'Type Here',
                style: AppTextStyles.medium.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.black,
                ),
                verticalTextAlign: TextAlignVertical.center,
                hintStyle: AppTextStyles.medium.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.black.withOpacity(0.5),
                ),
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
                    child: GeneratingResponseDialog(
                      duration: 5.seconds,
                      completionFunction: () {
                        Get.back();
                      },
                    ),
                  ),
                  barrierDismissible: false,
                  barrierColor: AppColors.black.withOpacity(0.75),
                );
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
                padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 14.h),
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
                _buildQuotesList(context),
                20.verticalSpace,
                _buildQuotesPageIndicator(context),
                20.verticalSpace,
                _buildEmotionAnalysis(context),
                25.verticalSpace,
                _buildEmotionPillHeader(context),
                10.verticalSpace,
                _buildEmotionPillRow(context),
                20.verticalSpace,
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
      height: 410.h,
      child: PageView.builder(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
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
                  'Sometime, the greatest of things, takes the longest to happens and demands the ultimate sacrifice for the ultimate rewards.',
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
                    'Quoter',
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
      controller: pageController,
      count: 10,
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
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer convallis mi cursus metus iaculis, non tempor ligula blandit. Ut bibendum elit quis augue tincidunt, eget vestibulum est mollis. Sed in efficitur sapien. Fusce nec semper nisl, a cursus mi. Curabitur quis orci nec lorem porta tempor. Fusce gravida auctor urna eu volutpat. Mauris sit amet velit sed eros tristique congue ut id nisl. Maecenas viverra hendrerit placerat.',
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
          children: [
            _buildJournalMoodPill(context: context, pillText: "Angry"),
            _buildJournalMoodPill(context: context, pillText: "Hate"),
            _buildJournalMoodPill(context: context, pillText: "Rage"),
            _buildJournalMoodPill(context: context, pillText: "Happiness"),
          ],
        ),
      ),
    );
  }

  Widget _buildJournalMoodPill({required BuildContext context,required String pillText}) {
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
