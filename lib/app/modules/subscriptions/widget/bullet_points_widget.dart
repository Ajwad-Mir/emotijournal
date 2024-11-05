import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BulletPointsWidget extends StatelessWidget {
  final String text;

  const BulletPointsWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 276.w,
      child: Row(

        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.circle, size: 8.0, color: AppColors.white),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              textScaler: const TextScaler.linear(1),
              style: AppTextStyles.normal
                  .copyWith(fontSize: 20.sp, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
