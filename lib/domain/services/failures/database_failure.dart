import '../../model/abstracts/exceptions/app_failure.dart';

/// A class representing a failure that occurs specifically within the database layer.
///
/// The [DatabaseFailure] class extends [AppFailure] and is used to encapsulate errors or failures
/// related to database operations. It is part of the application's error handling strategy, helping
/// distinguish between different types of failures by categorizing them as database-specific errors.
/// 
/// This class allows you to propagate database-related failures through the application, providing
/// a clear message and error code for debugging and handling in higher layers of the application.
class DatabaseFailure extends AppFailure {
  /// Creates a new instance of [DatabaseFailure].
  /// 
  /// The [code] is an integer representing the specific error code associated with the database failure.
  /// The [message] provides a human-readable description of the failure to aid debugging and handling.
  /// 
  /// This constructor passes the [code] and [message] parameters to the base class [AppFailure].
  DatabaseFailure({required super.code, required super.message});
}