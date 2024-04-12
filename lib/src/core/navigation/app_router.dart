import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vmodel/src/core/navigation/router_anmes.dart';
import 'package:vmodel/src/presentation/screens/home_page.screen.dart';
import 'package:vmodel/src/presentation/screens/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  final router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: Routes.startUp,
        name: "start",
        builder: (context, state) => const SplashScreen(),

      ),
      GoRoute(
          path: Routes.homeNavigation,
          builder: (context, state) => const HomeScreen(),
          routes: []
      )
  ]
  );
}