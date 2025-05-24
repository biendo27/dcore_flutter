part of 'di.dart';

@InjectableInit(
  generateForDir: [
    'lib/config/di',
    'lib/config/services',
    'lib/src/data/datasources/apis',
    'lib/src/data/datasources/sockets',
    'lib/src/data/repositories',
    'lib/src/domain/repositories',
    'lib/src/domain/usecases',
    'lib/src/presentation/blocs',
  ],
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)

void configureDependencies() => AppDI.source.init();

mixin AppDI {
  static GetIt source = GetIt.instance;

  static Future<void> initializeDependencies() async {
    source.allowReassignment = true;
    configureDependencies();
    LogDev.data('APP DI CONFIG INITIALIZED!');
    // NetWorkDI.init(injector);
    // ApiDI.init(injector);
    // RepositoryDI.init(injector);
  }

  static Future<void> resetDependencies() async {
    await source.reset();
    configureDependencies();
  }
}
