import 'package:event_plus/core/di/injector.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

const _development = 'development';
const _production = 'production';
const _test = 'test';

const devEnvironment = Environment(_development);
const prodEnvironment = Environment(_production);
const testEnvironment = Environment(_test);

final GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
GetIt configInjector({
  String? env,
  EnvironmentFilter? environmentFilter,
}) {
  return getIt.init(
    environmentFilter: environmentFilter,
    environment: env,
  );
}
