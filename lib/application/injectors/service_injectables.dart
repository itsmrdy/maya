part of 'injector.dart';

Future<void> serviceInjectables(GetIt serviceLocator) async {
  ///AAA
  ///BBB
  ///CCC
  ///DDD
  serviceLocator.registerLazySingleton(() => Dio());

  ///EEE
  ///FFF
  ///GGG
  ///HHH
  serviceLocator.registerLazySingleton(
    () => HttpClient(serviceLocator<Dio>()),
  );

  ///III
  ///JJJ
  ///KK
  ///LLL
  ///MMM
  serviceLocator.registerLazySingleton<ADatabase>(() {
    return MayaDatabaseSeeder(seeder: <Seeder>[]);
  });

  serviceLocator.registerLazySingleton<MayaDatabase>(() {
    return MayaDatabase();
  });

  serviceLocator.registerLazySingleton<MayaTransactionService>(
    () => MayaTransactionServiceImpl(
      httpClient: serviceLocator(),
      codenicLogger: serviceLocator(),
    ),
  );

  ///NNN
  ///OOO
  ///PPP
  ///QQQ
  ///RRR
  ///SSS
  serviceLocator.registerLazySingleton<AMayaAuthService>(
    () {
      return MayaAuthServiceImpl(
        database: serviceLocator<MayaDatabase>(),
        logger: serviceLocator<CodenicLogger>(),
      );
    },
  );

  ///TTT
  ///UUU
  ///VVV
  ///WWW
  ///XXX
  ///YYY
  ///ZZZ
}
