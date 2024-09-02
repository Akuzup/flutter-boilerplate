import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interceptors/api_token_interceptor.dart';

class NetworkingFactory {
  static Dio createDio(String baseUrl, SharedPreferences sharedPreferences,
      // BehaviorSubject onLogout,
      [bool isDebug = false]) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      // connectTimeout: 30000,
      // receiveTimeout: 6000,
    ))
      // ..interceptors.add(LoggerInterceptor())
      ..interceptors.add(ApiTokenInterceptor(
        sharedPreferences,
        // onLogout: onLogout,
      ));

    // if (isDebug) {
    //   dio
    //         ..interceptors.add(TelegramInterceptor(
    //           chatId: -894374098,
    //           token: '5338093905:AAFz-waA5krK3qNY1ElGjm11XvGy50VGz3w',
    //           projectId: 'VDone Bot',
    //           willSendSuccess: true,
    //         ))
    //         ..interceptors.add(LoggerInterceptor())
    //       //..interceptors.add(ErrorInterceptor())
    //       ;
    // }

    return dio;
  }
}
