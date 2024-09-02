// Copyright 2021 Fighttech.vn, Ltd. All rights reserved.

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const keyAuthentication = 'Authorization';
const keyApiKey = 'XApiKey';
const keyBear = 'Bearer';
const keyAcceptLanguage = 'Accept-Language';
const keySavedToken = '_keytoken';

class ApiTokenInterceptor extends Interceptor {
  final SharedPreferences _sharedPreferences;
  // final BehaviorSubject onLogout;
  final String? apiKey;

  ApiTokenInterceptor(
    this._sharedPreferences, {
    this.apiKey,
    // required this.onLogout,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = _sharedPreferences.getString(keySavedToken);
    if (apiKey?.isNotEmpty ?? false) {
      options.headers['Authorization'] = 'Bearer $apiKey';
    }

    if (accessToken?.isNotEmpty ?? false) {
      options.headers[keyAuthentication] = '$keyBear $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log('[Dio][ApiTokenInterceptor] error ${err.response}');
    }
    final errorCode = err.response?.data?['statusCode'];
    if ('401' == errorCode?.toString() || 401 == err.response?.statusCode) {
      // onLogout.sink.add(null);
    }

    super.onError(err, handler);
  }
}
