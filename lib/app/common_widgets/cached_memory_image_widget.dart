import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CachedBase64Image extends StatelessWidget {
  final String base64String;
  final double? width;
  final double? height;

  const CachedBase64Image({
    super.key,
    required this.base64String,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Remove "data:image/png;base64," or similar prefix if present
    final cleanBase64 = base64String.contains(',')
        ? base64String.split(',').last // Extract only the base64 part
        : base64String;

    return base64String.isNotEmpty
        ? Container(
      width: width ?? 40.w,
      height: height ?? 40.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: MemoryImage(base64Decode(cleanBase64)),
          fit: BoxFit.cover,
        ),
      ),
    )
        : Shimmer.fromColors(
      baseColor: Colors.white10,
      highlightColor: Colors.white24,
      child: Container(
        width: width ?? 40.w,
        height: height ?? 40.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withAlpha((255 * 0.1).round())
              : Colors.black.withAlpha((255 * 0.1).round()),
        ),
      ),
    );
  }
}
