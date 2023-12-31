import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/utils/app_assets.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_state.dart';

import '../core/theme/theme.dart';
import '../features/auth/presentation/screens/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return MaterialApp(
                theme: getAppTheme(),
                darkTheme: getAppDarkTheme(),
                themeMode: BlocProvider.of<TaskCubit>(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                title: AppStrings.appName,
                debugShowCheckedModeBanner: false,
                home: const SplashScreen());
          },
        );
      },
    );
  }
}
