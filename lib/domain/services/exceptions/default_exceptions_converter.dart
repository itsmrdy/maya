import 'package:codenic_logger/codenic_logger.dart';
import '../../model/abstracts/exceptions/exception_converter.dart';
import '../failures/default_failure.dart';

/// A class that handles converting generic exceptions into a `DefaultFailure`.
/// It extends `ExceptionConverter` and is used to map any type of `Exception` 
/// (or subclasses of it) into a generic failure type when an unknown error occurs.
///
/// The `DefaultExceptionsConverter` is useful when you want to catch and log 
/// any unexpected exceptions, and return a fallback failure (`DefaultFailure`) 
/// instead of allowing the application to crash or propagate unknown errors.
///
/// This class:
/// - Logs the exception details using a logger (`CodenicLogger`).
/// - Converts the exception into a `DefaultFailure`, which has a predefined error code 
///   and message, ensuring consistency in error handling.

class DefaultExceptionsConverter<T> extends ExceptionConverter<T, Exception, DefaultFailure> {
  const DefaultExceptionsConverter();
  /// Converts a caught exception into a `DefaultFailure` instance.
  ///
  /// - `logger`: The logger used to log the error message, exception details, and stack trace.
  /// - `message`: The message describing the failure scenario, which will be logged.
  /// - `exception`: The exception that was thrown, which is logged and mapped to a failure.
  /// - `stackTrace`: The stack trace of the exception (optional).
  /// - `data`: Additional custom data to be included in the log (optional).
  /// 
  /// Returns: A `DefaultFailure` instance, which represents a generic error.
  @override
  DefaultFailure onException({
    required CodenicLogger logger,
    required String message,
    required Exception exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    // Log the exception details, including custom data if provided.
    logger.error(
      MessageLog(
        id: 'unknown-default-failure',
        message: 'Unknown Failure: $message',
        data: data,
      ),
      error: exception,
      stackTrace: stackTrace,
    );

    // Return a DefaultFailure to represent a fallback error.
    return DefaultFailure();
  }
}
