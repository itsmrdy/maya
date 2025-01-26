import 'package:dartz/dartz.dart';
import 'package:maya/domain/model/abstracts/exceptions/app_failure.dart';

/// An abstract interface that defines the contract for database operations.
/// 
/// The [IDatabase] interface outlines the methods that any class responsible for interacting with 
/// a database should implement. This interface allows for abstraction and separation of concerns, 
/// enabling the use of different database implementations (e.g., SQLite, MongoDB, etc.) while maintaining 
/// a consistent interface for the rest of the application.
///
/// The methods defined in this interface allow for database creation, deletion, and retrieval of the 
/// database path, ensuring that all database-related operations can be performed in a standardized way.
/// 
/// Example implementation could be a class that interacts with SQLite:
/// ```dart
/// class MayaDatabase implements IDatabase {
///   @override
///   Future<Either<AppFailure, String>> createTableForDatabase() {
///     // Implementation for creating the table
///   }
/// 
///   @override
///   void deleteOrRemoveDatabase() {
///     // Implementation for deleting the database
///   }
/// 
///   @override
///   String? get databasePath {
///     // Implementation for retrieving the database path
///   }
/// }
/// ```
abstract interface class IDatabase {
  /// Creates the necessary tables for the database and initializes the database connection.
  /// 
  /// This method attempts to create the database tables and return the path to the created database.
  /// The return type is a [Future] that resolves to an [Either] object:
  /// - A [Right] containing the database path if the operation is successful.
  /// - A [Left] containing an [AppFailure] if the operation fails.
  ///
  /// The [AppFailure] should provide error details such as an error code and message.
  Future<Either<AppFailure, String>> createTableForDatabase();

  /// Deletes or removes the database entirely.
  /// 
  /// This method removes the database and its associated data. It could be used when the database 
  /// needs to be reset or cleaned up during testing, development, or after an error.
  void deleteOrRemoveDatabase();

  /// Retrieves the path to the database.
  /// 
  /// This getter provides the path to the current database file or storage location.
  /// It may return `null` if the database path has not been set or the database does not exist.
  String? get databasePath;
}