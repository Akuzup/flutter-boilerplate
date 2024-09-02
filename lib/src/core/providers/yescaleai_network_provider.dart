import 'package:app_core/app_core.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YescaleaiNetworkProvider {
  late Dio dio;

  final onLogout = BehaviorSubject();

  YescaleaiNetworkProvider(
    String baseUrl,
    String apiKey,
    SharedPreferences sharedPreferences,
  ) {
    dio = Dio(BaseOptions(baseUrl: baseUrl))
      ..interceptors.add(
        ApiTokenInterceptor(
          sharedPreferences,
          apiKey: apiKey,
          // onLogout: onLogout,
        ),
      )
      ..interceptors.add(LoggerInterceptor());
  }
}

// @module
// abstract class YescaleaiNetworkProvideModule {
//   @factory
//   @preResolve
//   YescaleaiNetworkProvider createYescaleaiNetworkProviderProd(
//       SharedPreferences sharedPreferences) {
//     final yescaleai = Configurations.yescaleaiConfiguration;

//     return YescaleaiNetworkProvider(
//       yescaleai.baseUrl,
//       yescaleai.apiKey,
//       sharedPreferences,
//     );
//   }
// }
