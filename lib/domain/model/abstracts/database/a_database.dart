import 'package:dartz/dartz.dart';

import '../../../../application/parameters/maya_auth_parameters.dart';
import '../../valueobjects/maya_auth_user_dto.dart';
import '../exceptions/app_failure.dart';

/// [ADatabase] is an abstract class that serves as the blueprint for database operations
/// in the application. It defines the essential methods that any concrete database class
/// (such as [MayaDatabase]) should implement in order to interact with the database.
///
/// The purpose of this class is to provide a standard interface for performing common
/// database operations, such as loading user data, copying the database from assets, 
/// and populating the database with initial data. Concrete implementations are expected
/// to handle the actual database logic.
///
/// **Methods:**
/// - `populate`: A method for populating the database with initial data (e.g., seed data).
/// - `loadUser`: Loads user data based on the provided authentication parameters.
/// - `copyDataBaseFromAsset`: Copies the database from the assets folder to the local storage
///   of the device (e.g., for initial setup).
///
abstract class ADatabase {
  const ADatabase();

  /// Populates the database with initial data (seeders).
  ///
  /// This method should be implemented in a subclass to seed the database with necessary 
  /// initial data, such as default user accounts or configuration settings. The actual 
  /// logic for populating the database will depend on the specific implementation.
  ///
  /// Example:
  /// - Insert predefined user records into the database.
  void populate();

  /// Loads user data from the database based on the provided [authParameters].
  ///
  /// This method retrieves user data from the database and returns it as a [MayaAuthUserDto]. 
  /// It uses the provided [authParameters] to filter or specify the data to load.
  ///
  /// Returns:
  /// - [Right] containing a [MayaAuthUserDto] if the user data was successfully loaded.
  /// - [Left] containing an [AppFailure] if the user could not be loaded or no data is found.
  Future<Either<AppFailure, MayaAuthUserDto>> loadUser({
    required MayaAuthParameters authParameters,
  });

  /// Copies the database from the assets folder to the application's local storage.
  ///
  /// This method is responsible for ensuring that the application's database is copied
  /// from the assets (where it may be bundled with the app) to the device's local storage.
  /// It will typically be called when the application is first launched to ensure that the
  /// necessary database is available for use.
  ///
  /// The method might also check if the database already exists in the local storage and
  /// avoid overwriting it if the copy already exists.
  Future<void> copyDataBaseFromAsset();
}