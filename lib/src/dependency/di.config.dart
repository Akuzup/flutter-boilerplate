// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_core/app_core.dart' as _i130;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../core/providers/yescaleai_network_provider.dart' as _i507;
import '../data/datasource/remote/yescaleai_api.dart' as _i14;
import '../data/repository/yescaleai_repository.impl.dart' as _i1034;
import '../domain/repository/yescalseai_repository.dart' as _i866;
import '../domain/usecase/yescaleai_usecase.dart' as _i853;
import '../presenstations/dashboard/bloc/dashboard_bloc.dart' as _i723;
import 'modules/datesource.dart' as _i522;
import 'modules/local_storage.dart' as _i655;
import 'modules/supabase.dart' as _i380;

const String _prod = 'prod';

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
  await _i130.AppCorePackageModule().init(gh);
  final supabaseModule = _$SupabaseModule();
  final localStorageModule = _$LocalStorageModule();
  final datesourceModule = _$DatesourceModule();
  gh.singleton<_i723.DashboardBloc>(() => _i723.DashboardBloc());
  await gh.singletonAsync<_i454.Supabase>(
    () => supabaseModule.initSupbase(),
    preResolve: true,
  );
  await gh.singletonAsync<_i460.SharedPreferences>(
    () => localStorageModule.prefs,
    preResolve: true,
  );
  gh.factory<_i361.Dio>(
    () => localStorageModule.dioProd(gh<_i460.SharedPreferences>()),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i507.YescaleaiNetworkProvider>(
      () => datesourceModule.createYescaleaiNetworkProvider(
            gh<String>(),
            gh<String>(),
            gh<_i460.SharedPreferences>(),
          ));
  gh.factory<_i14.YescaleaiApi>(
      () => _i14.YescaleaiApi(gh<_i507.YescaleaiNetworkProvider>()));
  gh.factory<_i866.YescaleaiRepository>(
      () => _i1034.YescaleaiRepositoryImpl(api: gh<_i14.YescaleaiApi>()));
  gh.factory<_i853.YescaleaiUsecase>(() =>
      _i853.YescaleaiUsecase(repository: gh<_i866.YescaleaiRepository>()));
  return getIt;
}

class _$SupabaseModule extends _i380.SupabaseModule {}

class _$LocalStorageModule extends _i655.LocalStorageModule {}

class _$DatesourceModule extends _i522.DatesourceModule {}
