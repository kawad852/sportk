import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sportk/utils/base_extensions.dart';

class CustomSmoothIndicator extends StatelessWidget {
  final int count, index;
  final Axis axis;

  const CustomSmoothIndicator({
    super.key,
    required this.count,
    required this.index,
    this.axis = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: index,
      count: count,
      axisDirection: axis,
      effect: WormEffect(
        dotWidth: 8,
        dotHeight: 8,
        dotColor: context.colorScheme.outlineVariant,
        activeDotColor: context.colorScheme.primary,
      ),
    );
  }
}
