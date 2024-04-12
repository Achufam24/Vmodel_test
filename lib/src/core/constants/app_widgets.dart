import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vmodel/src/core/constants/app_colors.dart';
import 'package:vmodel/src/core/constants/app_strings.dart';
import 'package:vmodel/src/core/widgets/text.dart';

class AppWidgets{
  final Widget logoIcon = TextBold("iBlog", color: AppColors.primaryBlue, fontSize: 50.sp,);
  final Widget appTextName  = TextSemiBold(
    AppStrings.appNAme,
    color: AppColors.background,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}