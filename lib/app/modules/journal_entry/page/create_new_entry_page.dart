import 'package:emotijournal/app/modules/journal_entry/controller/journal_entry_controller.dart';
import 'package:emotijournal/app/modules/journal_entry/dialogs/generating_response_dialog.dart';
import 'package:emotijournal/app/modules/journal_entry/page/response_view_page.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class CreateNewEntryPage extends GetView<JournalEntryController> {
  const CreateNewEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: _buildEmotionFieldWidget(context),
              ),
              40.verticalSpace,
              _buildAnalyzeButton(),
              50.verticalSpace
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmotionFieldWidget(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: MediaQuery(
              data: const MediaQueryData(textScaler: TextScaler.linear(1)),
              child: Obx(
                () => TextFormField(
                  controller: controller.emotionsTextController,
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.white,
                  ),
                  onChanged: (data) {
                    if (data.isNotEmpty) {
                      controller.currentTextAlign.value = TextAlign.start;
                    } else {
                      controller.currentTextAlign.value = TextAlign.center;
                    }
                    controller.update();
                  },
                  expands: true,
                  maxLines: null,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  textAlign: controller.currentTextAlign.value,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    hintText: controller.isListening.isFalse
                        ? "How are you feeling today? You can say what you need to say without worries. This is a safe space just for you."
                        : "We Are listening to you now. Say your heart’s desire.",
                    hintStyle: AppTextStyles.medium.copyWith(
                      fontSize: 20.sp,
                      color: AppColors.white.withOpacity(0.75),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(
                        color: AppColors.white.withOpacity(0.85),
                        width: 1.5.w,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(
                        color: AppColors.white.withOpacity(0.85),
                        width: 1.5.w,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(
                        color: AppColors.white,
                        width: 2.5.w,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 25.h,
          right: 40.w,
          child: CupertinoButton(
              onPressed: () {
                controller.isListening.value = !controller.isListening.value;
              },
              minSize: 0,
              padding: EdgeInsets.zero,
              pressedOpacity: 0.5,
              child: Obx(
                () => controller.isListening.isTrue
                    ? RippleAnimation(
                        duration: 2.seconds,
                        repeat: true,
                        color: AppColors.white.withOpacity(0.1),
                        ripplesCount: 4,
                        delay: 500.milliseconds,
                        minRadius: 30.w,
                        child: Container(
                          width: 60.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                            border: Border.all(
                              color: AppColors.white,
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 13.w, vertical: 13.h),
                          child: SvgPicture.asset(
                            Assets.svgMicListeningOn,
                            width: 34.w,
                            height: 40.h,
                          ),
                        ),
                      )
                    : Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: AppColors.white,
                            width: 1,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 13.w, vertical: 13.h),
                        child: SvgPicture.asset(
                          Assets.svgMicListeningOff,
                          width: 34.w,
                          height: 40.h,
                        ),
                      ),
              )),
        ),
      ],
    );
  }

  Widget _buildAnalyzeButton() {
    return CupertinoButton(
      onPressed: () async {
        await Get.dialog(
          Dialog(
            child: GeneratingResponseDialog(
              duration: 5.seconds,
              completionFunction: () {
                Get.off(
                  () => ResponseViewPage(),
                  transition: Transition.cupertino,
                  duration: 850.milliseconds,
                );
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
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.white,
              width: 2.0,
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                Assets.svgAnalyze,
                width: 30.w,
                height: 30.h,
              ),
              12.horizontalSpace,
              Text(
                'Analyze',
                textScaler: const TextScaler.linear(1),
                style: AppTextStyles.semiBold
                    .copyWith(fontSize: 14.sp, color: AppColors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
