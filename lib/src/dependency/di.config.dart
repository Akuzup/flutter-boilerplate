// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../core/providers/chat_network_provider.dart' as _i121;
import '../data/datasource/local/chat_local_datasource.dart' as _i41;
import '../data/datasource/remote/chat_api.dart' as _i264;
import '../data/repository/chat_repository.impl.dart' as _i870;
import '../domain/repository/chat_repository.dart' as _i146;
import '../domain/usecase/chat_usecase.dart' as _i104;
import '../presentations/chat_list/bloc/chat_list_bloc.dart' as _i815;
import '../presentations/dashboard/bloc/dashboard_bloc.dart' as _i932;
import 'modules/datesource.dart' as _i522;
import 'modules/local_storage.dart' as _i655;

const String _prod = 'prod';

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final localStorageModule = _$LocalStorageModule();
  final datesourceModule = _$DatesourceModule();
  await gh.singletonAsync<_i460.SharedPreferences>(
    () => localStorageModule.prefs,
    preResolve: true,
  );
  gh.singleton<_i932.DashboardBloc>(() => _i932.DashboardBloc());
  gh.factory<_i361.Dio>(
    () => localStorageModule.dioProd(gh<_i460.SharedPreferences>()),
    registerFor: {_prod},
  );
  gh.singleton<_i41.ChatLocalDatasource>(
    () => _i41.ChatLocalDatasource(gh<_i460.SharedPreferences>()),
  );
  gh.lazySingleton<_i121.ChatNetworkProvider>(
    () => datesourceModule.createChatNetworkProvider(
      gh<_i460.SharedPreferences>(),
    ),
  );
  gh.factory<_i264.ChatApi>(
    () => _i264.ChatApi(gh<_i121.ChatNetworkProvider>()),
  );
  gh.factory<_i146.ChatRepository>(
    () => _i870.ChatRepositoryImpl(
      api: gh<_i264.ChatApi>(),
      localDatasource: gh<_i41.ChatLocalDatasource>(),
    ),
  );
  gh.factory<_i104.ChatUsecase>(
    () => _i104.ChatUsecase(repository: gh<_i146.ChatRepository>()),
  );
  gh.singleton<_i815.ChatListBloc>(
    () => _i815.ChatListBloc(gh<_i104.ChatUsecase>()),
  );
  return getIt;
}

class _$LocalStorageModule extends _i655.LocalStorageModule {}

class _$DatesourceModule extends _i522.DatesourceModule {}
