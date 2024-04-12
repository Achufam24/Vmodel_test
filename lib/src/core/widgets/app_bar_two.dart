import 'package:flutter/material.dart';
import 'package:vmodel/src/core/constants/app_colors.dart';
import 'package:vmodel/src/core/utils/app_functions.dart';
import 'package:vmodel/src/core/widgets/app_back_button.dart';
import 'package:vmodel/src/core/widgets/text.dart';
import 'package:vmodel/src/core/widgets/touchable_opacity.dart';

class VModelAppBarTwo extends StatelessWidget implements PreferredSizeWidget {
  const VModelAppBarTwo({
    Key? key,
    required this.title,
    this.actions = const [],
    this.centerTitle = true,
    this.elevation,
    this.titleColor,
    this.backTap
  }) : super(key: key);

  final String title;
  final List<Widget> actions;
  final bool centerTitle;
  final double? elevation;
  final Color? titleColor;
  final VoidCallback? backTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      leading: TouchableOpacity(
        onTap: backTap ?? () => Navigator.pop(context),
        child: const AppBackButton(),
      ),
      title: TextBold(
        AppFunctions.capitalize(title), 
        fontSize: 22,
        color: titleColor ?? AppColors.primaryBlue,
      ),
      actions: actions,
      elevation: elevation ?? 0,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
