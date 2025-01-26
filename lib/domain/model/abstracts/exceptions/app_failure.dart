/// An abstract class that represents the base structure for all failures in the app.
/// 
/// This class provides a common interface for all failure types, encapsulating
/// the error code and message that can be used for consistent error handling across
/// the application. It is typically extended by more specific failure classes, 
/// like `NetworkFailure`, `DatabaseFailure`, etc., that define specific types of failures.
/// 
/// The class contains:
/// - `code`: An integer representing the error code associated with the failure.
/// - `message`: A human-readable description of the failure, providing more details.

abstract class AppFailure {
  final int code;
  final String message;

  /// Constructor that initializes the failure with a specific error code and message.
  const AppFailure({required this.code, required this.message});
}
