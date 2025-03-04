
import 'package:flutter/material.dart';

enum ImagePosition { left, right }

class WrapWithImage extends StatelessWidget {
  final ImagePosition imagePosition;
  final Widget image;
  final Widget text;

  const WrapWithImage({
    super.key,
    required this.imagePosition,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        if (imagePosition == ImagePosition.left) ...[
          Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 16),
            child: image,
          ),
          Flexible(
            child: text,
          ),
        ] else ...[
          Flexible(
            child: text,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16),
            child: image,
          ),
        ],
      ],
    );
  }
}