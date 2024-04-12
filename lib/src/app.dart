import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vmodel/src/core/theme/light_theme.dart';
import 'package:vmodel/src/data/data_sources/graph_provider.dart';
import 'package:vmodel/src/injection_container.dart';
import 'package:vmodel/src/presentation/screens/home_page.screen.dart';
import 'package:vmodel/src/providers.dart';

class VmodelApp extends StatelessWidget {
  const VmodelApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MultiProvider(
          providers: providers,
          child: MaterialApp.router(
            title: 'Flutter Demo',
            theme: lightTheme,
            routeInformationProvider:
            getIt<GoRouter>().routeInformationProvider,
            routeInformationParser: getIt<GoRouter>().routeInformationParser,
            routerDelegate: getIt<GoRouter>().routerDelegate,
            backButtonDispatcher: getIt<GoRouter>().backButtonDispatcher,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}