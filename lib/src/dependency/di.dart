import 'package:app_core/fima_core.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final injector = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
  externalPackageModulesBefore: [
    ExternalModule(FimaCorePackageModule),
  ],
  externalPackageModulesAfter: [
    // ExternalModule(EcommercePackageModule),
  ],
)
Future<void> configureDependencies({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async =>
    init(injector,
        environment: environment, environmentFilter: environmentFilter);
