import 'package:app_core/app_core.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/configurations/configurations.dart';

@module
abstract class LocalStorageModule {
  @preResolve
  @singleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @prod
  Dio dioProd(SharedPreferences sharedPreferences) =>
      NetworkingFactory.createDio(
        Configurations.supabaseProjectUrl,
        sharedPreferences,
      );
}
