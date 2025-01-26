import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../../application/parameters/maya_auth_parameters.dart';
import '../../domain/model/abstracts/database/a_database.dart';
import '../../domain/model/abstracts/exceptions/app_failure.dart';
import '../../domain/services/failures/database_failure.dart';
import '../seeder/user_seeder.dart';

import '../../domain/model/interfaces/database.dart';
// import 'package:path/path.dart' as path;

import 'package:sqlite3/sqlite3.dart';
import '../../domain/model/interfaces/seeder.dart';

/// MayaDatabase is a subclass of [ADatabase] that implements [IDatabase] interface.
/// This class is responsible for managing the SQLite database used in the application, including
/// creating, opening, and populating it with initial data. It also handles database failures and
/// provides methods to manipulate the database schema.
class MayaDatabase extends ADatabase implements IDatabase {
  /// A list of [Seeder] objects used for populating the database.
  final List<Seeder> seeder;

  /// The SQLite [Database] instance that is used for database operations.
  Database? _database;

  /// A list of seeders (initial data providers) used to populate the database.
  List<Seeder>? seedersList;

  /// The path where the database is stored.
  String? _databasePath;

  /// Constructor for [MayaDatabase] that initializes the [seeder] list and sets the
  /// database path to the specified file in the current working directory.
  ///
  /// [seeder] - List of seeders to populate the database.
  MayaDatabase({
    required this.seeder,
  }) : seedersList = seeder {
    // Set the database path to the 'maya_database.db' in the current directory.
    stderr.writeln("Preparing the database path......");
    _databasePath = '${Directory.current.path}/assets/maya_database.db';
    // Open the SQLite database at the specified path
    _database = sqlite3.open(_databasePath!);
  }

  /// Attempts to create and open a database at the specified [databasePath].
  /// If the database already exists, it will be opened. If not, a new one will be created
  /// with a table called "User" containing the columns: `id`, `username`, `password`, and `balance`.
  ///
  /// It also deletes or removes any existing database before attempting to open or create a new one.
  ///
  /// Returns:
  /// - A [Right] containing the database path if successful.
  /// - A [Left] containing a [DatabaseFailure] if the database could not be found or opened.
  @override
  Future<Either<AppFailure, String>> createTableForDatabase() async {
    // Call to remove any existing database before creating a new one
    deleteOrRemoveDatabase();
    try {
      // If the database was opened or created successfully, return its path
      if (_database != null) {
        // Drop the 'User' table if it exists and recreate it
        _database!.execute(
            '''DROP TABLE IF EXISTS User; CREATE TABLE User (id INTEGER PRIMARY KEY, username TEXT, password TEXT, balance REAL)''');
        return right(_database!.toString());
      } else {
        // Return a failure if the database is null
        return left(DatabaseFailure(
            code: 404, message: 'Cannot find database using $_databasePath'));
      }
    } catch (e) {
      // Return a failure if there's an error opening or creating the database
      return left(DatabaseFailure(
          code: 500, message: 'Error opening or creating database: $e'));
    }
  }

  /// Deletes or disposes of the existing database instance if it exists.
  ///
  /// This method ensures that any resources held by the database are released,
  /// preparing the system for the creation of a new database.
  @override
  void deleteOrRemoveDatabase() async {
    if (_database != null) _database!.dispose();
  }

  /// The path to the database file, or an empty string if no path is set.
  @override
  String? get databasePath => _databasePath ?? '';

  /// Populates the database with initial data by using the provided seeders.
  ///
  /// This method goes through each [Seeder] in the [seedersList] and performs the necessary
  /// actions to insert data into the database. For example, the [UserSeeder] is responsible for
  /// inserting predefined user data into the 'User' table.
  @override
  void populate() {
    if (seedersList != null) {
      // Loop through each seeder and populate the database
      for (var seeder in seedersList!) {
        if (seeder is UserSeeder) {
          UserSeeder userSeeder = UserSeeder()..run();

          // Insert the seeded data into the 'User' table
          for (var i = 0; i < userSeeder.data.length; i++) {
            final user = userSeeder.data[i];
            _database!.execute(
              'INSERT INTO User(username, password, balance) VALUES("${user.username}", "${user.password}", ${user.balance})',
            );
          }

          // Print the inserted data
          final result = _database!.select('SELECT * FROM User');
          for (var row in result) {
            stderr.writeln(
                'User with username: ${row['username']} has been generated');
          }
          stderr.writeln('Database has been seeded successfully....');
        }
      }
    }
  }

  /// Loads user data based on the provided authentication parameters.
  ///
  /// This is a placeholder method that can be implemented later for user authentication
  /// or data loading logic. The [authParameters] can be used to load user-specific data
  /// from the database if required.
  @override
  Future<bool> loadUser({required MayaAuthParameters authParameters}) async {
    // Placeholder for user loading logic
    final result = _database!
        .select('''SELECT * FROM User WHERE username= ${authParameters.username}
    AND password=${authParameters.password}''');
    ///RETURN A MODEL HERE
    return result.isNotEmpty;
  }

  @override
  Future<void> copyDataBaseFromAsset() async {
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = '${directory.path}/my_database.db';

    // Check if the file already exists to avoid overwriting it
    if (File(dbPath).existsSync()) {
      stderr.writeln('Database already exists at $dbPath');
      return;
    }

    // Copy the database from the assets folder
    ByteData data = await rootBundle.load('assets/maya_database.db');
    List<int> bytes = data.buffer.asUint8List();
    File(dbPath).writeAsBytesSync(bytes);
    stderr.writeln('Database copied to $dbPath');
  }
}
