import 'package:emotijournal/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoWidget extends StatelessWidget {
  final double width;
  final double height;

  const LogoWidget({super.key, required this.width, required this.height});
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo-tag',
      child: Material(
        type: MaterialType.transparency,
        child: SvgPicture.asset(
          Theme.of(context).brightness == Brightness.dark
              ? Assets.svgDarkLogo
              : Assets.svgLightLogo,
          width: width,
          height: height
        ),
      ),
    );
  }
}