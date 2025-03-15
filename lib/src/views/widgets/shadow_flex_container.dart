import 'package:flutter/material.dart';

import '../utils/colors.dart';


class ShadowFlexContainer extends StatelessWidget {
  final Widget child;
  final double radius;

  const ShadowFlexContainer({
    super.key,
    required this.child,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.circular(radius)),
      child: child,
    );
  }
}
