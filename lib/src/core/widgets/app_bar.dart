import 'package:flutter/material.dart';
import 'package:vmodel/src/core/constants/app_colors.dart';
import 'package:vmodel/src/core/widgets/text.dart';

class VModelAppBar extends StatelessWidget implements PreferredSizeWidget {
  const VModelAppBar({
    Key? key,
    required this.title,
    this.elevation,
    this.actions = const [],
    this.centerTitle = false,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;
  final double? elevation;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: TextBold(
        title,
        fontSize: 22,
        color: AppColors.primaryBlue,
        fontWeight: FontWeight.w700,
      ),
      actions: actions,
      elevation: elevation ?? 0.0,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}