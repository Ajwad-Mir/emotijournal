import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class GradientIconWithBorder extends StatelessWidget {
  final String assetPath;
  final double size;
  final Gradient gradient;

  const GradientIconWithBorder({
    super.key,
    required this.assetPath,
    this.size = 50,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 2,
      height: size + 2,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return gradient.createShader(bounds);
        },
        blendMode: BlendMode.srcIn,
        child: SvgPicture.asset(
          assetPath,
          width: size,
          height: size,

        ),
      ),
    );
  }
}