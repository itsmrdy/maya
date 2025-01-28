part of 'injector.dart';

Future<void> applicationInjectables(GetIt serviceLocator) async {
  ///AAA
  serviceLocator.registerFactory<AuthUserCubit>(
    () => AuthUserCubit(
      mayAuthService: serviceLocator<AMayaAuthService>(),
    ),
  );

  ///BBB
  ///CCC
  ///DDD
  ///EEE
  ///FFF
  ///GGG
  ///HHH
  ///III
  ///JJJ
  ///KK
  ///LLL
  ///MMM
  serviceLocator.registerFactory(
    () => MayaFetchTransactionsCubit(
      mayaTransactionService: serviceLocator<MayaTransactionService>(),
    ),
  );

  serviceLocator.registerFactory(
    () => MayaPostTransactionsCubit(
      mayaTransactionService: serviceLocator<MayaTransactionService>(),
    ),
  );

  serviceLocator.registerFactory(
    () => MayaAuthLogoutCubit(
      mayaAuthService: serviceLocator<AMayaAuthService>(),
    ),
  );

  serviceLocator.registerFactory(
    () => MayaCheckSessionCubit(
      mayaAuthService: serviceLocator<AMayaAuthService>(),
    ),
  );

  ///NNN
  ///OOO
  ///PPP
  ///QQQ
  ///RRR
  ///SSS
  ///TTT
  ///UUU
  ///VVV
  ///WWW
  serviceLocator.registerFactory<WalletBalanceCubit>(
    () => WalletBalanceCubit(),
  );

  ///XXX
  ///YYY
  ///ZZZ
}
