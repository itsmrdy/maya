import 'package:codenic_logger/codenic_logger.dart';
import 'package:dartz/dartz.dart';
import '../abstracts/exceptions/app_failure.dart';
import '../abstracts/exceptions/exception_converter.dart';
import '../../services/failures/default_failure.dart';
import '../../services/exceptions/default_exceptions_converter.dart';

/// A utility function that handles exceptions by applying a series of `ExceptionConverter`s,
/// catching and logging exceptions, and returning a consistent failure type (`AppFailure`).
/// This function executes an asynchronous action and catches any exceptions that might occur.
///
/// It supports multiple `ExceptionConverter` implementations, allowing you to define how different
/// exception types should be handled and converted into specific failures. If no specific exception
/// converter is provided, a default converter (`DefaultExceptionsConverter`) is used as a fallback.
///
/// The function:
/// - Tries to execute the provided `action` (a function returning a `Future<Either<AppFailure, T>>`).
/// - Applies the `ExceptionConverter`s sequentially to handle exceptions and map them into appropriate failures.
/// - Logs any unexpected exceptions and returns a `DefaultFailure` as a fallback.
///
/// This is useful for managing errors across various parts of the application in a standardized way.
/// The action result is either a successful response (wrapped in `Right`) or a failure (wrapped in `Left`).
///
/// **Parameters**:
/// - `action`: A function that returns a `Future<Either<AppFailure, T>>`. It represents the operation
///   to be executed, which may succeed or fail.
/// - `logger`: A logger used to log error messages, stack traces, and other relevant data.
/// - `failureMessage`: A custom message describing the failure that will be logged.
/// - `customData`: Optional additional data to be included in the logs when the exception occurs.
/// - `exceptionsList`: An optional list of `ExceptionConverter` objects that define how specific
///   exceptions should be handled. If the list is empty, the default converter (`DefaultExceptionsConverter`)
///   will be used.

/// Returns: A `Future<Either<AppFailure, T>>` where:
/// - `Left`: Contains an `AppFailure` indicating the type of failure (e.g., `DefaultFailure`).
/// - `Right`: Contains the successful result of type `T`.
Future<Either<AppFailure, T>> tryAndCatchTheExpcetions<T>({
  required Future<Either<AppFailure, T>> Function() action,
  required CodenicLogger logger,
  required String failureMessage,
  Map<String, dynamic>? customData,
  List<ExceptionConverter<T, Exception, AppFailure>>? exceptionsList,
}) async {
  try {
    // Create a list of exception converters, adding the default one if necessary
    final List<ExceptionConverter<T, Exception, AppFailure>>
        exceptionConvertersList =
        <ExceptionConverter<T, Exception, AppFailure>>[
      ...exceptionsList ?? <ExceptionConverter<T, Exception, AppFailure>>[],
    ];

    // If there are no converters, add the default converter as a fallback
    if (exceptionsList == null) {
      exceptionConvertersList.add(DefaultExceptionsConverter<T>());
    }

    // Apply each exception converter in the list to the action
    return await exceptionConvertersList.fold(
      action,
      (Future<Either<AppFailure, T>> Function() previousValue,
          ExceptionConverter<T, Exception, AppFailure> element) {
        return () {
          return element.call(
            action: action,
            logger: logger,
            failureMessage: failureMessage,
          );
        };
      },
    )();
  } catch (exception, stackTrace) {
    // Log any unexpected exceptions or errors that were not handled by the converters
    logger.error(
      MessageLog(
        id: 'Exception Failure has return',
      ),
      error: exception,
      stackTrace: stackTrace,
    );

    // Return a default failure when an unknown exception occurs
    return Left<AppFailure, T>(DefaultFailure());
  }
}
