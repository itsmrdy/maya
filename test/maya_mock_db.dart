import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maya/application/parameters/maya_auth_parameters.dart';
import 'package:maya/domain/model/abstracts/database/a_database.dart';
import 'package:maya/domain/model/abstracts/exceptions/app_failure.dart';
import 'package:maya/domain/model/entities/maya_user_entities.dart';
import 'package:maya/domain/model/valueobjects/maya_auth_user_dto.dart';
import 'package:maya/domain/services/failures/database_failure.dart';

class MayaMockDb extends ADatabase {
  final List<MayaUserEntities> users = [
    MayaUserEntities(
        userid: 1005,
        username: 'testaccount5',
        password: 'Qwerty@123#',
        balance: 90000),
    MayaUserEntities(
        userid: 1006,
        username: 'testaccount6',
        password: 'Str0ng!Passw0rd',
        balance: 100000),
    MayaUserEntities(
        userid: 1007,
        username: 'testaccount7',
        password: 'Maya@2023#Strong',
        balance: 100000),
    MayaUserEntities(
        userid: 1008,
        username: 'testaccount8',
        password: 'Secure!P@ssw0rd123',
        balance: 100000),
    MayaUserEntities(
        userid: 1009,
        username: 'testaccount9',
        password: 'Test@456P@ss!',
        balance: 100000),
    MayaUserEntities(
        userid: 1010,
        username: 'testaccount10',
        password: 'P@ssw0rd789#',
        balance: 100000),
  ];
  @override
  Future<void> copyDataBaseFromAsset() {
    throw UnimplementedError();
  }

  @override
  Future<Either<AppFailure, MayaAuthUserDto>> loadUser({
    required MayaAuthParameters authParameters,
  }) async {
    final resultFromDb = users
        .where(
          (user) =>
              authParameters.username == user.username &&
              authParameters.password == user.password,
        )
        .firstOrNull;

    if (resultFromDb != null) {
      return Right(
        MayaAuthUserDto.fromJson({
          "username": resultFromDb.username,
          "password": resultFromDb.password,
          "userid": resultFromDb.userid,
          "balance": resultFromDb.balance,
        }),
      );
    }
    return Left(DatabaseFailure(
        code: 404, message: 'No data found on given parameters'));
  }

  @override
  void populate() {}
}
