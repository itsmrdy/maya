import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:maya/infrastracture/database/maya_database.dart';
import 'package:maya/infrastracture/seeder/database_seeder.dart';
import 'package:maya/infrastracture/seeder/user_seeder.dart';

void main(List<String> arguments) {
  var runner = CommandRunner(
    'Database Seeder',
    'A tool for seeding a local SQLite database',
  )..addCommand(UserSeederCommand());

  runner.run(arguments).catchError(
    (error) {
      if (error is UsageException) {
        print('Error: ${error.message}');
      }
    },
  );
}

class UserSeederCommand extends Command {
  @override
  String get description =>
      'A command to populate the SQLite database with sample user data';

  @override
  String get name => 'seed';

  UserSeederCommand() {
    argParser.addOption('seeder', abbr: 's', help: 'Seeder class to use');
  }

  @override
  void run() async {
    stderr.writeln('Seeding the SQLite database...');

    DatabaseSeeder databaseSeeder = DatabaseSeeder(
      mayaDatabase: MayaDatabase(
        seeder: [UserSeeder()],
      ),
    );

    databaseSeeder.run();
  }
}
