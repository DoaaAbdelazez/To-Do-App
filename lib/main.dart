import 'package:flutter/material.dart';
import 'package:to_do_app/core/database/cache/cache_helper.dart';

import 'app/app.dart';
import 'core/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await  setup();
await sl<CacheHelper>().init();

  runApp(const MyApp());
}



  
