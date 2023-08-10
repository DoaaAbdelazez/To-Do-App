import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/app_assets.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';

import '../core/theme/theme.dart';
import '../features/auth/presentation/screens/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:getAppTheme(),
      darkTheme:getAppDarkTheme(),
      themeMode: ThemeMode.light,
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      
      home:  const SplashScreen()
    );
  }
}