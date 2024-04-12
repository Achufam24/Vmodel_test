import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vmodel/src/core/constants/app_colors.dart';


class CustomShimmer extends StatelessWidget {
  const CustomShimmer({super.key, required this.child, this.baseColor, this.highlightColor});
  final Widget child;

  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.primaryGrey2.withOpacity(.4),
      highlightColor:highlightColor ?? Colors.grey[100]!,
      child: child
    );
  }
}