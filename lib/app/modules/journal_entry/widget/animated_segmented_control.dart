import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedSegmentedControl extends StatefulWidget {
  final List<String> segments;
  final Function(int) onSegmentSelected;

  const AnimatedSegmentedControl({
    super.key,
    required this.segments,
    required this.onSegmentSelected,
  });

  @override
  State<AnimatedSegmentedControl> createState() => _AnimatedSegmentedControlState();
}

class _AnimatedSegmentedControlState extends State<AnimatedSegmentedControl> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.white, width: 1.0),
      ),
      child: LayoutBuilder(
          builder: (context, constraints) {
            final segmentWidth = constraints.maxWidth / widget.segments.length;
            return Stack(
              children: [
                // Animated selection indicator
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  left: _selectedIndex * segmentWidth,
                  top: 0,
                  bottom: 0,
                  width: segmentWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                ),
                // Segment buttons
                Row(
                  children: List.generate(
                    widget.segments.length,
                        (index) => Expanded(
                      child: CupertinoButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                          widget.onSegmentSelected(index);
                        },
                        minSize: 0,
                        padding: EdgeInsets.zero,
                        child: Center(
                          child: Text(
                            widget.segments[index],
                            textScaler: TextScaler.linear(1),
                            style: AppTextStyles.medium.copyWith(
                              color: _selectedIndex == index ? AppColors.black : Theme.of(context).brightness == Brightness.dark ? AppColors.white : AppColors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}