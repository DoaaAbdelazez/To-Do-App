import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/bloc/bloc_observer.dart';
import 'package:to_do_app/core/database/cache/cache_helper.dart';
import 'package:to_do_app/core/database/sqflite_helper/sqflite_helper.dart';
import 'package:to_do_app/features/task/presentation/cubit/task_cubit.dart';

import 'app/app.dart';
import 'core/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await setup();
  await sl<CacheHelper>().init();
  sl<SqfliteHelper>().intiDB();

  runApp(BlocProvider(
    create: (context) => TaskCubit()..getTheme()..getTasks(),
    child: const MyApp(),
  ));
}
