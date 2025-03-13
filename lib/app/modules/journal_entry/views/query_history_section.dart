import 'package:animate_do/animate_do.dart';
import 'package:emotijournal/app/models/journal_model.dart';
import 'package:emotijournal/app/modules/journal_entry/controller/journal_entry_controller.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
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
        itemCount: journal.queries.length,
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textScaler: const TextScaler.linear(1),
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 20.sp,
                      color: AppColors.white,
                    ),
                  ),
                  12.verticalSpace,
                  _buildEmotionAnalysis(context, index),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmotionAnalysis(BuildContext context, int index) {
    return Column(
      children: [
        _buildEmotionPieChartWidget(context),
        12.verticalSpace,
        Text(
          journal.queries[index].analysis,
          textScaler: TextScaler.linear(1),
          style: AppTextStyles.light.copyWith(
            fontSize: 16.sp,
            color: AppColors.white,
          ),
        ),
      ],
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
                        color: Color(int.parse(
                            journal.emotionsList[index].colorHex.replaceAll("#", "0xFF"))),
                      ),
                    ),
                    5.horizontalSpace,
                    Text(
                      journal.emotionsList[index].emotion,
                      textScaler: TextScaler.linear(1),
                      style: AppTextStyles.bold.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return 15.verticalSpace;
              },
              itemCount: journal.emotionsList.length,
            ),
          ),
          15.horizontalSpace,
          SizedBox(
            width: 175.w,
            height: 200.h,
            child: PieChart(
              PieChartData(
                sections: journal.emotionsList
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
                              element.colorHex.replaceAll("#", "0xFF"))),),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
