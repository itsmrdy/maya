import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqlite3/sqlite3.dart';
import '../../application/parameters/maya_auth_parameters.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/model/abstracts/exceptions/app_failure.dart';
import '../../domain/model/valueobjects/maya_auth_user_dto.dart';
import '../../domain/model/abstracts/database/a_database.dart';
import '../../domain/services/failures/database_failure.dart';

/// [MayaDatabase] is a subclass of [ADatabase] that handles the operations related to the SQLite
/// database used within the application. This class is responsible for copying the database from
/// assets to the device's local storage, loading user data from the database, and ensuring that
/// the database is properly populated with necessary data.

class MayaDatabase extends ADatabase {
  /// The SQLite [Database] instance that is used for database operations.
  Database? _database;

  /// Copies the database from the assets folder to the application's local directory.
  ///
  /// This method checks if the database already exists in the application's documents directory.
  /// If it exists, it deletes the existing database and copies it again from the assets folder to
  /// ensure the latest version of the database is available.
  /// If the database doesn't exist, it will simply copy it from the assets.
  ///
  /// The method handles asynchronous operations and will print debug information when running in
  /// debug mode.
  @override
  Future<void> copyDataBaseFromAsset() async {
    // Get the application document directory path where the database will be stored
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = '${directory.path}/my_database.db';

    // Log the copying process if in debug mode
    if (kDebugMode) {
      print('Copying database from assets to applications directory');
      print('using path: $dbPath');
    }

    // Check if the file already exists to avoid overwriting it
    if (File(dbPath).existsSync()) {
      if (kDebugMode) print('Database already exists at $dbPath');
      // If the database exists, delete the existing one before copying a fresh copy
      await File(dbPath).delete();
      copyDataBaseFromAsset(); // Recurse to copy the new version of the database
      return;
    }

    // Copy the database from the assets folder to the application's documents directory
    ByteData data = await rootBundle.load('assets/maya_database.db');
    List<int> bytes = data.buffer.asUint8List();
    File(dbPath).writeAsBytesSync(bytes);

    // Log the completion of the copy operation
    if (kDebugMode) print('Database copied to $dbPath');
  }

  /// Loads user data from the database based on the provided [authParameters].
  ///
  /// This method retrieves user data from the 'User' table in the SQLite database stored
  /// in the application documents directory. It opens the database if not already opened,
  /// and executes a query to fetch user data.
  ///
  /// If the user data is found, it returns a [MayaAuthUserDto] containing the data.
  /// If no data is found, it returns a [DatabaseFailure] indicating that no data was found
  /// matching the parameters.
  ///
  /// This method demonstrates how to interact with the database asynchronously using the
  /// SQLite package.
  @override
  Future<Either<AppFailure, MayaAuthUserDto>> loadUser({
    required MayaAuthParameters authParameters,
  }) async {
    // Get the application document directory path where the database is stored
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = '${directory.path}/my_database.db';

    // Open the database if it hasn't been opened yet
    _database ??= sqlite3.open(dbPath);

    // Execute a query to select all users from the 'User' table
    final result = _database!.select(
        '''SELECT * FROM User where username = '${authParameters.username}'
    AND password = '${authParameters.password}' ''');

    // Log the result of the query if in debug mode
    if (kDebugMode) print(result.toList());

    // If results are found, return the first user as a [MayaAuthUserDto]
    if (result.isNotEmpty) {
      for (final user in result) {
        return Right(MayaAuthUserDto.fromJson(user));
      }
    }

    // Return a failure if no user data is found
    return Left(DatabaseFailure(
        code: 404, message: 'No data found on given parameters'));
  }

  /// Placeholder method for populating the database with initial data.
  ///
  /// This method can be implemented to seed the database with required data during
  /// the app's initialization. Currently, the method doesn't perform any operations.
  @override
  void populate() {}
}
