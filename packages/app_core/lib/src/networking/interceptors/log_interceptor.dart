// Copyright 2022 Fighttech.vn, Ltd. All rights reserved.

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../utils/log_print.dart';

String prettyJsonStr(Map<dynamic, dynamic> json) {
  final encoder = JsonEncoder.withIndent('  ', (data) => data.toString());
  return encoder.convert(json);
}

class LoggerInterceptor extends Interceptor {
  final Function(DioException)? onRequestError;
  final bool Function(Response<dynamic>)? ignoreReponseDataLog;

  LoggerInterceptor({
    this.onRequestError,
    this.ignoreReponseDataLog,
  });

  void _print(dynamic message) {
    debugPrint(message);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final formData = options.data;
    String formDataText = '';

    if (formData is FormData) {
      try {
        formDataText = jsonEncode(formData.fields.map((e) => e).toList());
      } catch (e) {
        log('[bot_interceptor]--->');
        log(e.toString());
      }
      try {
        formDataText = formDataText +
            jsonEncode(formData.files
                .map((e) => {
                      'key': e.key,
                      'name': e.value.filename,
                    })
                .toList());
      } catch (e) {
        log('[bot_interceptor]--->');
        log(e.toString());
      }
    }

    _print(prettyJsonStr(
      {
        'from': 'onRequest',
        'Time': DateTime.now().toString(),
        'statusCode': options.data,
        'baseUrl': options.baseUrl,
        'path': options.path,
        'queryParameters': options.queryParameters,
        'header': options.headers,
        'method': options.method,
        'requestData':
            formDataText.isNotEmpty ? formDataText : options.data?.toString(),
      },
    ));
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    _print(prettyJsonStr({
      'from': 'onResponse',
      'Time': DateTime.now().toString(),
      'method': response.requestOptions.method,
      'statusCode': response.statusCode,
      'baseUrl': response.requestOptions.baseUrl,
      'path': response.requestOptions.path,
      'header': response.requestOptions.headers,
      'extra': response.extra,
      'queryParameters': response.requestOptions.queryParameters,
      if (ignoreReponseDataLog?.call(response) != false)
        'responseData': response.data,
    }));

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _print(prettyJsonStr({
      'from': 'onError',
      'Time': DateTime.now().toString(),
      'method': err.requestOptions.method,
      'baseUrl': err.requestOptions.baseUrl,
      'path': err.requestOptions.path,
      'header': err.requestOptions.headers,
      'extra': err.requestOptions.extra,
      'queryParameters': err.requestOptions.queryParameters,
      'statusCode': err.response?.statusCode,
      'data': err.response?.data,
      'type': err.type,
      'message': err.message,
      'error': err.error,
      'responseData': err.requestOptions.data
    }));
    super.onError(err, handler);
  }
}
