import 'package:flutter/material.dart';
import 'package:vmodel/src/core/constants/app_colors.dart';


class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_back_ios_outlined,
      color: AppColors.primaryBlue,
        );
  }
}