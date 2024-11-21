import 'package:animate_do/animate_do.dart';
import 'package:emotijournal/app/modules/home/controller/home_controller.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendarHeaderWidget extends GetView<HomeController> {
  const CustomCalendarHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _StickyHeaderDelegate(
        child: FadeInUp(
          delay: 200.milliseconds,
          child: Container(
            width: Get.width,
            height: 125.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
              color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkBackgroundColor : AppColors.lightBackgroundColor,
            ),
            child: Obx(
              () => TableCalendar(
                currentDay: DateTime.now(),
                focusedDay: controller.selectedDate.value,
                firstDay: DateTime(2005, 01, 01),
                lastDay: DateTime.now(),
                rangeSelectionMode: RangeSelectionMode.disabled,
                dayHitTestBehavior: HitTestBehavior.translucent,
                weekendDays: const [DateTime.saturday, DateTime.sunday],
                calendarFormat: CalendarFormat.week,
                selectedDayPredicate: (day) {
                  return isSameDay(controller.selectedDate.value, day);
                },
                daysOfWeekVisible: false,
                rowHeight: 90.h,
                daysOfWeekHeight: 0,
                onDaySelected: (selectedDay, focusedDay) async {
                  controller.selectedDate.value = selectedDay;
                  controller.journalList.clear();
                  controller.update();
                  if (controller.isCollapsed.isTrue) {
                    controller.scrollController.position.animateTo(0, duration: 500.milliseconds, curve: Curves.linear);
                  }
                  await controller.getAllJournalEntries();
                },
                shouldFillViewport: true,
                availableGestures: AvailableGestures.horizontalSwipe,
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  headerPadding: EdgeInsets.zero,
                  headerMargin: EdgeInsets.zero,
                  formatButtonVisible: false,
                  rightChevronVisible: false,
                  leftChevronVisible: false,
                ),
                pageJumpingEnabled: false,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) => const SizedBox.shrink(),
                  headerTitleBuilder: (context, date) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Center(
                        child: Text(
                          DateFormat('MMMM yyyy').format(date),
                          style: AppTextStyles.medium.copyWith(
                            fontSize: 24.sp,
                            color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
                          ),
                        ),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    return Container(
                      width: 100.w,
                      height: 100.h,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: AppColors.primaryGradient,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day.day.toString(),
                            textScaler: const TextScaler.linear(1),
                            style: AppTextStyles.medium.copyWith(fontSize: 24.sp, color: AppColors.white),
                          ),
                          Text(
                            DateFormat(DateFormat.ABBR_WEEKDAY).format(day),
                            textScaler: const TextScaler.linear(1),
                            style: AppTextStyles.normal.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  holidayBuilder: (context, day, focusedDay) {
                    return Container(
                      width: 100.w,
                      height: 100.h,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day.day.toString(),
                            textScaler: const TextScaler.linear(1),
                            style: AppTextStyles.medium.copyWith(
                              fontSize: 24.sp,
                              color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
                            ),
                          ),
                          Text(
                            DateFormat(DateFormat.ABBR_WEEKDAY).format(day),
                            textScaler: const TextScaler.linear(1),
                            style: AppTextStyles.normal.copyWith(
                              fontSize: 16.sp,
                              color: (day.weekday == DateTime.sunday || day.weekday == DateTime.saturday)
                                  ? Colors.red
                                  : Theme.of(context).brightness == Brightness.dark
                                      ? AppColors.darkTextColor
                                      : AppColors.lightTextColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    return Container(
                      width: 100.w,
                      height: 100.h,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day.day.toString(),
                            textScaler: const TextScaler.linear(1),
                            style: AppTextStyles.medium.copyWith(
                              fontSize: 24.sp,
                              color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
                            ),
                          ),
                          Text(
                            DateFormat(DateFormat.ABBR_WEEKDAY).format(day),
                            textScaler: const TextScaler.linear(1),
                            style: AppTextStyles.normal.copyWith(
                              fontSize: 16.sp,
                              color: (day.weekday == DateTime.sunday || day.weekday == DateTime.saturday)
                                  ? Colors.red
                                  : Theme.of(context).brightness == Brightness.dark
                                      ? AppColors.darkTextColor
                                      : AppColors.lightTextColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  todayBuilder: (context, currentDate, focusedDay) {
                    return Container(
                      width: 100.w,
                      height: 100.h,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentDate.day.toString(),
                            textScaler: const TextScaler.linear(1),
                            style: AppTextStyles.medium.copyWith(
                              fontSize: 24.sp,
                              color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
                            ),
                          ),
                          Text(
                            DateFormat(DateFormat.ABBR_WEEKDAY).format(currentDate),
                            textScaler: const TextScaler.linear(1),
                            style: AppTextStyles.normal.copyWith(
                              fontSize: 16.sp,
                              color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  defaultBuilder: (context, day, focusedDay) {
                    return Container(
                      width: 100.w,
                      height: 100.h,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day.day.toString(),
                            textScaler: const TextScaler.linear(1),
                            style: AppTextStyles.medium.copyWith(
                              fontSize: 24.sp,
                              color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextColor : AppColors.lightTextColor,
                            ),
                          ),
                          Text(
                            DateFormat(DateFormat.ABBR_WEEKDAY).format(day),
                            textScaler: const TextScaler.linear(1),
                            style: AppTextStyles.normal.copyWith(
                              fontSize: 16.sp,
                              color: (day.weekday == DateTime.sunday || day.weekday == DateTime.saturday)
                                  ? Colors.red
                                  : Theme.of(context).brightness == Brightness.dark
                                      ? AppColors.darkTextColor
                                      : AppColors.lightTextColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  disabledBuilder: (context, day, focusedDay) {
                    return Container(
                      width: 100.w,
                      height: 100.h,
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            day.day.toString(),
                            textScaler: const TextScaler.linear(1),
                            style: AppTextStyles.medium.copyWith(
                              fontSize: 24.sp,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.darkTextColor.withOpacity(0.4)
                                  : AppColors.lightTextColor.withOpacity(0.4),
                            ),
                          ),
                          Text(
                            DateFormat(DateFormat.ABBR_WEEKDAY).format(day),
                            textScaler: const TextScaler.linear(1),
                            style: AppTextStyles.normal.copyWith(
                              fontSize: 16.sp,
                              color: (day.weekday == DateTime.sunday || day.weekday == DateTime.saturday)
                                  ? Colors.red.withOpacity(0.4)
                                  : Theme.of(context).brightness == Brightness.dark
                                      ? AppColors.darkTextColor.withOpacity(0.4)
                                      : AppColors.lightTextColor.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                calendarStyle: const CalendarStyle(
                  markersAlignment: Alignment.center,
                ),
                weekNumbersVisible: false,
                pageAnimationCurve: Curves.linearToEaseOut,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 125.h;

  @override
  double get minExtent => 125.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
