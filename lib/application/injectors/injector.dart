import 'package:get_it/get_it.dart';

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
      applicationInjectables(serviceLocator),
      serviceInjectables(serviceLocator),
      dependencyInjectables(serviceLocator),
    ],
  );
}
