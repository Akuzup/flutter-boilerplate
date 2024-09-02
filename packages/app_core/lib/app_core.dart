library fima_core;

export 'src/dependency_injection/app_core_micro.module.dart';
export 'src/networking/api_response.dart';
export 'src/networking/exception/api_exception.dart';
export 'src/networking/exception/response_dio_ext.dart';
export 'src/networking/interceptors/api_token_interceptor.dart';
export 'src/networking/interceptors/log_interceptor.dart';
export 'src/networking/networking_factory.dart';
export 'src/router/navigator_page.dart';
export 'src/router/route_module.dart';
export 'src/router/route_observer.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
