import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:vmodel/src/core/constants/app_colors.dart';
import 'package:vmodel/src/core/constants/app_widgets.dart';
import 'package:vmodel/src/core/navigation/router_anmes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _toOnboard() async {
        context.replace(Routes.homeNavigation);
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), _toOnboard);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
      ),
      body: Center(child:  AppWidgets().logoIcon .animate(
          onPlay: (controller) =>
              controller.repeat(reverse: true))
          .shimmer(
          delay: 200.ms,
          duration: 1200.ms,
          color: AppColors.primaryColor.withOpacity(.4)).shake(hz: 4, curve: Curves.easeInOutCubic).scaleXY(end: 1.1, duration: 600.ms)
          .then(delay: 600.ms)
          .scaleXY(end: 1 / 1.1))
    );
  }
}