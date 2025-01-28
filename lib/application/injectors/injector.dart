import 'package:codenic_logger/codenic_logger.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../usecase/maya_auth_logout_cubit.dart';
import '../usecase/maya_check_session_cubit.dart';
import '../usecase/maya_fetch_transactions_cubit.dart';
import '../usecase/wallet_balance_cubit.dart';
import '../../domain/model/abstracts/network/http_client.dart';
import '../../domain/model/abstracts/maya_services/maya_transaction_service.dart';
import '../../domain/services/maya_services/maya_transaction_service_impl.dart';
import '../usecase/auth_user_cubit.dart';
import '../../domain/model/abstracts/database/a_database.dart';
import '../../domain/model/interfaces/seeder.dart';
import '../../domain/services/maya_services/maya_auth_service_impl.dart';
import '../../infrastracture/database/maya_database_seeder.dart';

import '../../domain/model/abstracts/maya_services/maya_auth_service.dart';
import '../../infrastracture/database/maya_database.dart';
import '../usecase/maya_post_transactions_cubit.dart';

part 'application_injectables.dart';
part 'dependency_injectables.dart';
part 'service_injectables.dart';

/// A singleton service locator instance for managing and accessing app dependencies.
///
/// The `GetIt` package is used here to provide a global service locator, which is a pattern
/// that helps manage the app's dependencies in a centralized way. `serviceLocator` is the
/// instance of `GetIt` that holds all the services, repositories, and other dependencies
/// that are injected into the app.
///
/// The code below defines the `initializer` function, which is responsible for setting up
/// and injecting dependencies into the service locator. It asynchronously calls separate
/// functions that inject different types of dependencies into the service locator.

final GetIt serviceLocator = GetIt.instance;

/// Initializes the service locator by injecting necessary dependencies into the app.
///
/// This function ensures that the app's services, repositories, and other dependencies are
/// properly set up before the app runs. It makes use of `Future.wait` to execute multiple
/// asynchronous dependency injection functions in parallel, ensuring that all dependencies
/// are injected before the app starts its main operations.
///
/// **Dependencies injected**:
/// - `applicationInjectables`: Injects application-level services and configurations.
/// - `serviceInjectables`: Injects other service-related dependencies.
/// - `dependencyInjectables`: Injects additional external or helper dependencies.

Future<void> initializer() async {
  await Future.wait(
    <Future<void>>[
      serviceInjectables(serviceLocator),
      applicationInjectables(serviceLocator),
      dependencyInjectables(serviceLocator),
    ],
  ).then((_) async {
    await serviceLocator<MayaDatabase>().copyDataBaseFromAsset();
  });
}
