import 'dart:io';
import '../../domain/model/interfaces/seeder.dart';
import '../database/maya_database.dart';

/// A class responsible for seeding the database with initial data.
/// 
/// The [DatabaseSeeder] class is used to initialize the database and populate it with data.
/// It works by first ensuring that the database is created and opened successfully, and then
/// it invokes the [populate] method from the [MayaDatabase] class to insert the necessary
/// data into the database. This class is useful during application setup, testing, or development
/// to ensure that the database contains predefined data before use.
class DatabaseSeeder extends Seeder {
  /// The [MayaDatabase] instance used to interact with the actual database.
  final MayaDatabase mayaDatabase;

  /// Creates a new instance of [DatabaseSeeder] with the specified [mayaDatabase].
  /// The [mayaDatabase] is responsible for managing database creation and population.
  DatabaseSeeder({required this.mayaDatabase});

  /// Runs the seeding process, which involves:
  /// 1. Ensuring the database exists and is opened.
  /// 2. Preparing the database for population.
  /// 3. Populating the database with predefined data via the [populate] method.
  ///
  /// This method first checks if the database path is available. If so, it attempts to open the
  /// database and create necessary tables. After ensuring the database is ready, it invokes
  /// [mayaDatabase.populate()] to insert sample data into the database.
  ///
  /// If any issues arise during the database creation or population, the process will terminate
  /// without making any changes to the database.
  @override
  Future<void> run() async {
    // Check if the database path is available and valid
    if (mayaDatabase.databasePath != null) {
      stderr.writeln('Running database seeder.........');

      // Attempt to create the table(s) and open the database
      final db = await mayaDatabase.createTableForDatabase();

      // Check if the database was opened successfully
      if (db.isRight()) {
        stderr.writeln(
            'Database has been opened successfully, now preparing the data for population');
        // Populate the database with initial data
        mayaDatabase.populate();
        return;
      }
      // If opening the database failed, no further action is taken
      return;
    }
  }
}