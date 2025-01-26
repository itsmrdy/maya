import '../../model/abstracts/exceptions/app_failure.dart';
import '../../model/enums/http_error.dart';
/// A default failure class that extends `AppFailure` to represent a generic failure scenario.
/// 
/// This class is used to handle cases where the failure doesn't fall into a more specific 
/// category, such as network or database failures. It maps to the `HttpError.notFound` enum value, 
/// which typically signifies that a resource was not found (HTTP status code 404).
/// 
/// The `DefaultFailure` class can be used as a fallback failure type in scenarios where 
/// an error does not match a predefined category, providing consistency in error handling.
class DefaultFailure extends AppFailure {
  
  /// Constructor that initializes the `DefaultFailure` with the HTTP status code and 
  /// message associated with the `HttpError.notFound` error.
  DefaultFailure()
      : super(
          code: HttpError.notFound.code,       // Sets the error code to 404
          message: HttpError.notFound.message, // Sets the error message to 'Error not found'
        );
}
