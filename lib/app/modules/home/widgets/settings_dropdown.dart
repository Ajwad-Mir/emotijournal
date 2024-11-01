import 'package:emotijournal/app/modules/home/controller/home_controller.dart';
import 'package:emotijournal/generated/assets.dart';
import 'package:emotijournal/global/constants/app_colors.dart';
import 'package:emotijournal/global/constants/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingsDropdown extends GetView<HomeController> {
  const SettingsDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSvgContainer(
      width: 180.w,
      startColor: AppColors.primaryGradient.colors.first,
      endColor: AppColors.primaryGradient.colors.last,
      arrowRadius: 5.r,
      cornerRadius: 15.r,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              onPressed: () {},
              minSize: 0,
              padding: EdgeInsets.zero,
              pressedOpacity: 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.svgThemeSelection),
                      5.horizontalSpace,
                      Text(
                        "Theme",
                        textScaler: const TextScaler.linear(1),
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            5.verticalSpace,
            const Divider(
              color: AppColors.white,
              thickness: 0.5,
            ),
            5.verticalSpace,
            CupertinoButton(
              onPressed: () {},
              minSize: 0,
              padding: EdgeInsets.zero,
              pressedOpacity: 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.svgSubscriptions),
                      5.horizontalSpace,
                      Text(
                        "Subscription",
                        textScaler: const TextScaler.linear(1),
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            5.verticalSpace,
            const Divider(
              color: AppColors.white,
              thickness: 0.5,
            ),
            5.verticalSpace,
            CupertinoButton(
              onPressed: () {},
              minSize: 0,
              padding: EdgeInsets.zero,
              pressedOpacity: 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.svgLogout),
                      5.horizontalSpace,
                      Text(
                        "Logout",
                        textScaler: const TextScaler.linear(1),
                        style: AppTextStyles.medium.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveSvgContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double cornerRadius;
  final Color? startColor;
  final Color? endColor;
  final Widget? child;
  final double arrowRadius;

  const ResponsiveSvgContainer({
    Key? key,
    this.width,
    this.height,
    this.cornerRadius = 16.0,
    this.startColor = const Color(0xFF00DAB9),
    this.endColor = const Color(0xFF2BCEEF),
    this.child,
    this.arrowRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final containerWidth = width ?? constraints.maxWidth;
        final containerHeight = height ?? constraints.maxHeight;

        return CustomPaint(
          size: Size(containerWidth, containerHeight),
          painter: ResponsiveSvgPainter(
            width: containerWidth,
            height: containerHeight,
            cornerRadius: cornerRadius,
            startColor: startColor!,
            endColor: endColor!,
            arrowRadius: arrowRadius,
          ),
          child: Container(
            width: containerWidth,
            height: containerHeight,
            child: child,
          ),
        );
      },
    );
  }
}

class ResponsiveSvgPainter extends CustomPainter {
  final double width;
  final double height;
  final double cornerRadius;
  final Color startColor;
  final Color endColor;
  final double arrowRadius;

  ResponsiveSvgPainter({
    required this.width,
    required this.height,
    required this.cornerRadius,
    required this.startColor,
    required this.endColor,
    required this.arrowRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [startColor, endColor],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(
        Rect.fromPoints(
          Offset(0, -size.height * 0.1),
          Offset(size.width, size.height * 1.1),
        ),
      )
      ..style = PaintingStyle.fill;

    final path = Path();

    // Top-left corner
    path.moveTo(cornerRadius, 0);

    // Top right corner with potential arrow
    path.lineTo(width - cornerRadius - arrowRadius, 0);

    // Optional right-side arrow
    if (arrowRadius > 0) {
      _addRightSideArrow(path, width, height);
    }

    // Bottom right corner
    path.lineTo(width - cornerRadius, height);
    path.quadraticBezierTo(width, height, width, height - cornerRadius);

    // Bottom left corner
    path.lineTo(width, cornerRadius);
    path.quadraticBezierTo(width, 0, width - cornerRadius, 0);

    path.close();

    canvas.drawPath(path, paint);
  }

  void _addRightSideArrow(Path path, double width, double height) {
    final arrowBaseWidth = arrowRadius * 2;
    final arrowHeight = arrowRadius * 1.5;

    // Move to the point just before the arrow
    path.lineTo(width - cornerRadius - arrowRadius, 0);

    // Top of the arrow
    path.lineTo(width - cornerRadius, -arrowHeight / 2);

    // Right tip of the arrow
    path.lineTo(width - cornerRadius + arrowBaseWidth / 2, 0);

    // Back down to the container bottom
    path.lineTo(width - cornerRadius - arrowRadius, 0);
  }

  @override
  bool shouldRepaint(covariant ResponsiveSvgPainter oldDelegate) {
    return oldDelegate.width != width ||
        oldDelegate.height != height ||
        oldDelegate.cornerRadius != cornerRadius ||
        oldDelegate.startColor != startColor ||
        oldDelegate.endColor != endColor ||
        oldDelegate.arrowRadius != arrowRadius;
  }
}