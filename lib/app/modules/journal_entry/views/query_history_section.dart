import 'package:animate_do/animate_do.dart';
import 'package:emotijournal/app/models/journal_model.dart';
import 'package:emotijournal/app/modules/journal_entry/controller/journal_entry_controller.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class QueryHistorySection extends GetView<JournalManagementController> {
  final JournalModel journal;

  const QueryHistorySection({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: journal.queries.length - 1,
        itemBuilder: (context, index) {
          return FadeInUp(
            delay: 100.milliseconds + (10 * index).milliseconds,
            child: Container(
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
                    journal.queries[index].query,
                    textScaler: const TextScaler.linear(1),
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 20.sp,
                      color: AppColors.white,
                    ),
                  ),
                  12.verticalSpace,
                  Text(
                    journal.queries[index].analysis,
                    textAlign: TextAlign.start,
                    textScaler: const TextScaler.linear(1),
                    style: AppTextStyles.light.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.white,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
