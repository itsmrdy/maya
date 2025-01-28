import 'package:codenic_logger/codenic_logger.dart';
import 'package:dartz/dartz.dart';

import 'app_failure.dart';

/// A base class for converting exceptions to domain-specific `AppFailure`
/// types in a functional programming style using the `dartz` package.
/// 
/// The `ExceptionConverter` class helps to encapsulate the logic of handling
/// exceptions in a way that separates the business logic from error handling.
/// It attempts to execute a given action and, if an exception of type `E`
/// is thrown, it maps that exception to an `AppFailure` via the `onException`
/// method, logging the error and returning the failure wrapped in a `Left`.
///
/// This is useful for ensuring consistent error handling across your application
/// when dealing with specific exception types and their corresponding failures.
///
/// **Example Usage**:
/// ```dart
/// class NetworkExceptionConverter extends ExceptionConverter<Data, NetworkException, NetworkFailure> {
///   @override
///   NetworkFailure onException({
///     required CodenicLogger logger,
///     required String message,
///     required NetworkException exception,
///     StackTrace? stackTrace,
///     Map<String, dynamic>? data,
///   }) {
///     logger.error(message, exception, stackTrace);
///     return NetworkFailure(message: message, error: exception.toString(), data: data);
///   }
/// }
/// ```
abstract class ExceptionConverter<T, E extends Exception, F extends AppFailure> {
  const ExceptionConverter();
  /// Executes an asynchronous action and handles exceptions by mapping them to 
  /// an `AppFailure`. If an exception of type `E` is thrown, the `onException`
  /// method is invoked to create an appropriate failure response.
  ///
  /// - `action`: The action to be executed. It's a function that returns a 
  ///   `Future<Either<AppFailure, T>>`, typically representing a successful result 
  ///   (Right) or a failure (Left).
  /// - `logger`: The logger used to log error details.
  /// - `failureMessage`: A message describing the failure to be logged.
  /// - `customData`: Optional additional data to include with the error details.
  /// 
  /// Returns: A `Future<Either<AppFailure, T>>` which either contains a successful 
  /// result (Right) or a failure (Left).
  Future<Either<AppFailure, T>> call({
    required Future<Either<AppFailure, T>> Function() action,
    required CodenicLogger logger,
    required String failureMessage,
    Map<String, dynamic>? customData,
  }) async {
    try {
      return await action();
    } on E catch (exception, stacktrace) {
      return Left<AppFailure, T>(onException(
        logger: logger,
        message: failureMessage,
        exception: exception,
        stackTrace: stacktrace,
      ));
    }
  }

  /// The method to be implemented in subclasses that defines how exceptions of type `E`
  /// should be converted into a specific `AppFailure`. This method should log the error
  /// and return an appropriate failure response.
  ///
  /// - `logger`: The logger used to log error details.
  /// - `message`: The failure message to be logged.
  /// - `exception`: The thrown exception to be converted into a failure.
  /// - `stackTrace`: The stack trace of the exception (optional).
  /// - `data`: Optional additional data for the failure.
  /// 
  /// Returns: An instance of `F`, the domain-specific failure.
  F onException({
    required CodenicLogger logger,
    required String message,
    required E exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  });
}
