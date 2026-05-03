import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../networking/interceptors/log_interceptor.dart';

class ChatNetworkProvider {
  late final Dio dio;

  final onLogout = BehaviorSubject<void>();

  ChatNetworkProvider(
    String baseUrl,
    String apiKey,
    SharedPreferences sharedPreferences, {
    int timeout = 60,
  }) {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: timeout),
      receiveTimeout: Duration(seconds: timeout),
    ))
      ..interceptors.add(LoggerInterceptor());
  }

  void dispose() {
    onLogout.close();
    dio.close();
  }
}
