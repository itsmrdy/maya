import 'package:codenic_logger/codenic_logger.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maya/application/parameters/maya_auth_parameters.dart';
import 'package:maya/domain/model/abstracts/database/a_database.dart';
import 'package:maya/domain/model/abstracts/exceptions/app_failure.dart';
import 'package:maya/domain/model/entities/maya_user_entities.dart';
import 'package:maya/domain/services/maya_services/maya_auth_service_impl.dart';

import 'maya_codenic_logger.dart';
import 'maya_mock_db.dart';

void main() {
  late ADatabase database;
  late MayaAuthParameters userMockData1;
  late MayaAuthParameters userMockData2;
  late CodenicLogger codenicLogger;

  setUp(() {
    database = MayaMockDb();
    userMockData1 = MayaAuthParameters(
      username: 'testaccount10',
      password: 'P@ssw0rd789#',
    );
    userMockData2 = MayaAuthParameters(
      username: '1235',
      password: 'test',
    );
    codenicLogger = MayaCodenicLogger();
  });

  group(
    'Test the authentication of the app',
    () {
      test(
        'authenticate user from database data using correct credentials',
        () async {
          final authService = MayaAuthServiceImpl(
            database: database,
            logger: codenicLogger,
          );

          final Either<AppFailure, MayaUserEntities> result =
              await authService.login(authParameters: userMockData1);

          // Assert
          result.fold(
            (failure) {
              expect(failure, isA<AppFailure>());
            },
            (user) {
              // Assert that the returned user entity is of the correct type
              expect(user, isA<MayaUserEntities>());
              expect(user.username, userMockData1.username);
            },
          );
        },
      );

      test(
        'authenticate user from database data using wrong credentials',
        () async {
          final authService = MayaAuthServiceImpl(
            database: database,
            logger: codenicLogger,
          );

          final Either<AppFailure, MayaUserEntities> result =
              await authService.login(authParameters: userMockData2);

          // Assert
          result.fold(
            (failure) {
              expect(failure, isA<AppFailure>());
            },
            (user) {
              // Assert that the returned user entity is of the correct type
              expect(user, isA<MayaUserEntities>());
              expect(user.username, userMockData2.username);
            },
          );
        },
      );
    },
  );
}
