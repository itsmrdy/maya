import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maya/application/parameters/maya_auth_parameters.dart';
import 'package:maya/domain/model/abstracts/database/a_database.dart';
import 'package:maya/domain/model/abstracts/exceptions/app_failure.dart';
import 'package:maya/domain/model/valueobjects/maya_auth_user_dto.dart';

import 'maya_mock_db.dart';

void main() {
  late ADatabase database;
  late MayaAuthParameters user1;
  late MayaAuthParameters user2;
  late MayaAuthParameters user3;

  setUp(() {
    database = MayaMockDb();
    user1 = MayaAuthParameters(
      username: 'testaccount10',
      password: 'P@ssw0rd789#',
    );
    user2 = MayaAuthParameters(
      username: 'invalidusername',
      password: 'P@ssw0rd789#',
    );
    user3 = MayaAuthParameters(
      username: 'testaccount10',
      password: 'invalidpassword',
    );
  });

  group(
    'Test user authentication with correct and wrong credentials',
    () {
      test(
        'Test with correct username and correct password',
        () async {
          Either<AppFailure, MayaAuthUserDto> result =
              await database.loadUser(authParameters: user1);
          // Check that the result is a Right and contains the expected type
          expect(result.isRight(), isTrue);
          // Ensure that the value inside the Right is of type MayaAuthUserDto
          expect(result.fold((_) => null, (r) => r), isA<MayaAuthUserDto>());
        },
      );

      test(
        'Test with correct username and wrong password',
        () async {
          Either<AppFailure, MayaAuthUserDto> result =
              await database.loadUser(authParameters: user2);
          // Check that the result is a Right and contains the expected type
          expect(result.isLeft(), isTrue);
          // Ensure that the value inside the Right is of type MayaAuthUserDto
          expect(result.fold((l) => l, (_) => null), isA<AppFailure>());
        },
      );

      test(
        'Test with correct password and wrong username',
        () async {
          Either<AppFailure, MayaAuthUserDto> result =
              await database.loadUser(authParameters: user3);
          // Check that the result is a Right and contains the expected type
          expect(result.isLeft(), isTrue);
          // Ensure that the value inside the Right is of type MayaAuthUserDto
          expect(result.fold((l) => l, (_) => null), isA<AppFailure>());
        },
      );
    },
  );
}
