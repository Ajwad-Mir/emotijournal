import 'package:animate_do/animate_do.dart';
import 'package:emotijournal/app/modules/subscriptions/controller/subscription_controller.dart';
import 'package:emotijournal/app/modules/subscriptions/widget/bullet_points_widget.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SubscriptionPage extends GetView<SubscriptionsController> {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Subscription',
          textScaler: const TextScaler.linear(1),
          style: AppTextStyles.semiBold.copyWith(fontSize: 20.sp, color: AppColors.white),
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
      extendBodyBehindAppBar: true,
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              28.verticalSpace,
              FadeInUp(child: _buildOffersList(context)),
              20.verticalSpace,
              FadeInUp(delay: 200.milliseconds, child: _buildOffersPageIndicator(context)),
              Obx(
                () => AnimatedSwitcher(
                  duration: 250.milliseconds,
                  reverseDuration: 250.milliseconds,
                  switchInCurve: Curves.linear,
                  switchOutCurve: Curves.linear,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: controller.offers[controller.currentIndex.value].isCurrentPlan == false
                      ? Column(
                          children: [
                            41.verticalSpace,
                            _buildSelectPlanButton(context),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOffersList(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 635.h,
      child: PageView.builder(
        controller: controller.pageController,
        scrollDirection: Axis.horizontal,
        itemCount: controller.offers.length,
        onPageChanged: (index) {
          controller.currentIndex.value = index;
        },
        itemBuilder: (context, index) {
          return _buildOfferWidget(
            context: context,
            title: controller.offers[index].title,
            description: controller.offers[index].description,
            benefits: controller.offers[index].benefits,
            monthlyPrice: controller.offers[index].monthlyPrice == 0.00 ? "Free" : "\$${controller.offers[index].monthlyPrice}/Month",
            isCurrentPlan: controller.offers[index].isCurrentPlan,
          );
        },
      ),
    );
  }

  Widget _buildOfferWidget({
    required BuildContext context,
    required String title,
    required String description,
    required List<String> benefits,
    required String monthlyPrice,
    required bool isCurrentPlan,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 28.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: AppColors.white,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          50.verticalSpace,
          Text(
            title,
            textAlign: TextAlign.center,
            textScaler: const TextScaler.linear(1),
            style: AppTextStyles.light.copyWith(
              fontSize: 36.sp,
              color: AppColors.white,
            ),
          ),
          25.verticalSpace,
          SizedBox(
            width: Get.width,
            child: Text(
              description,
              textAlign: TextAlign.center,
              textScaler: const TextScaler.linear(1),
              style: AppTextStyles.light.copyWith(
                fontSize: 20.sp,
                color: AppColors.white,
              ),
            ),
          ),
          40.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 44.w),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BulletPointsWidget(text: 'Unlimited AI chats'),
                BulletPointsWidget(text: 'Extensive emotions list'),
                BulletPointsWidget(text: 'Text and audio journal entries'),
                BulletPointsWidget(text: 'Extensive mood insights'),
              ],
            ),
          ),
          const Spacer(),
          Text(
            monthlyPrice,
            textScaler: const TextScaler.linear(1),
            style: AppTextStyles.light.copyWith(
              fontSize: 20.sp,
              color: AppColors.white,
            ),
          ),
          19.verticalSpace,
          if (isCurrentPlan == true) ...[
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25.r),
                ),
                color: AppColors.white,
              ),
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Center(
                child: Text(
                  "Current Plan",
                  textScaler: const TextScaler.linear(1),
                  style: AppTextStyles.light.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildOffersPageIndicator(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller.pageController,
      count: controller.offers.length,
      effect: ScrollingDotsEffect(
        activeStrokeWidth: 2.6,
        activeDotScale: 1.3,
        activeDotColor: AppColors.white,
        maxVisibleDots: 5,
        radius: 8,
        spacing: 10,
        dotHeight: 12,
        dotColor: AppColors.white.withAlpha(50),
        dotWidth: 12,
      ),
    );
  }

  Widget _buildSelectPlanButton(BuildContext context) {
    return CupertinoButton(
      onPressed: () async {},
      minSize: 0,
      padding: EdgeInsets.zero,
      pressedOpacity: 0.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppColors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
          child: Text(
            "Select Plan",
            textScaler: const TextScaler.linear(1),
            style: AppTextStyles.light.copyWith(
              fontSize: 20.sp,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}
