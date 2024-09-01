// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_core/fima_core.dart' as _i139;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../presenstations/dashboard/bloc/dashboard_bloc.dart' as _i723;
import 'modules/local_storage.dart' as _i655;
import 'modules/supabase.dart' as _i380;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  await _i139.FimaCorePackageModule().init(gh);
  final supabaseModule = _$SupabaseModule();
  final localStorageModule = _$LocalStorageModule();
  gh.singleton<_i723.DashboardBloc>(() => _i723.DashboardBloc());
  await gh.singletonAsync<_i454.Supabase>(
    () => supabaseModule.initSupbase(),
    preResolve: true,
  );
  await gh.singletonAsync<_i460.SharedPreferences>(
    () => localStorageModule.prefs,
    preResolve: true,
  );
  return getIt;
}

class _$SupabaseModule extends _i380.SupabaseModule {}

class _$LocalStorageModule extends _i655.LocalStorageModule {}
