// Copyright 2022 Fighttech.vn, Ltd. All rights reserved.

import 'package:json_annotation/json_annotation.dart';

import 'exception/api_exception.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  @JsonKey(name: 'status', includeIfNull: false, readValue: _readValueStatus)
  final int status;

  final String? errorCode;
  final String? code;
  final String? errorString;
  final String? errors;

  @JsonKey(name: 'data', includeIfNull: false)
  final T? _data;

  ApiResponse({
    required this.status,
    this.errorCode,
    this.code,
    this.errorString,
    this.errors,
    T? data,
  }) : _data = data;

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Object?) fromT) {
    final response = _$ApiResponseFromJson(json, fromT);

    return response;
  }

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  T get data => _getData();

  bool get success => _success();

  T _getData() {
    _checkException();
    return _data as T;
  }

  bool _success() {
    _checkException();
    return status <= 200 || status >= 210 || status == 201;
  }

  void _checkException() {
    if (errorCode?.isNotEmpty ?? false) {
      throw ApiException(message: errorCode!);
    }
  }
}

Object? _readValueStatus(Map p1, String p2) {
  if (p1[p2] != null) {
    return p1[p2];
  }

  if (p1['status_code'] != null) {
    return p1['status_code'];
  }

  if (p1['success'] == true) {
    return 200;
  }

  return 200;
}

class ErrorInfo {
  final int code;
  final String message;

  ErrorInfo(this.code, this.message);

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'code': code});
    result.addAll({'message': message});

    return result;
  }

  factory ErrorInfo.fromJson(Map<String, dynamic> map) {
    return ErrorInfo(
      map['code']?.toInt() ?? 0,
      map['message'] ?? '',
    );
  }
}
