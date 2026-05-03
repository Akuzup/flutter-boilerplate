import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

abstract class InjectorGet {
  T get<T extends Object>() => injector.get<T>();
}
