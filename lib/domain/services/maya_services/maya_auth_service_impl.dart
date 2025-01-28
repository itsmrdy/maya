import 'dart:convert';

import 'package:codenic_logger/codenic_logger.dart';
import 'package:dartz/dartz.dart';
import '../../model/abstracts/database/a_database.dart';
import '../../model/entities/maya_user_entities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../application/parameters/maya_auth_parameters.dart';
import '../../model/abstracts/exceptions/app_failure.dart';
import '../../model/abstracts/maya_services/maya_auth_service.dart';
import '../../model/functions/try_and_catch_the_exception.dart';
import '../../model/interfaces/http_request.dart';
import '../failures/database_failure.dart';

class MayaAuthServiceImpl extends AMayaAuthService implements IHttpRequest {
  MayaAuthServiceImpl({
    required ADatabase database,
    required CodenicLogger logger,
  })  : _mayaDatabase = database,
        _logger = logger;

  final ADatabase _mayaDatabase;
  final CodenicLogger _logger;

  @override
  Future<Either<AppFailure, MayaUserEntities>> login({
    required MayaAuthParameters authParameters,
  }) async {
    return sendRequest<MayaUserEntities>(
      messageLog: MessageLog(id: 'authenticate-user'),
      action: () async {
        final user = await _mayaDatabase.loadUser(
          authParameters: authParameters,
        );

        return user.fold(
          (l) => Left(
            DatabaseFailure(
                code: 404, message: 'User not found or exist in database'),
          ),
          (user) async {
            SharedPreferences sharedPref =
                await SharedPreferences.getInstance();
            sharedPref.setString('user', jsonEncode(user.toJson()));
            return Right(user.toEntity());
          },
        );
      },
    );
  }

  @override
  Future<Either<AppFailure, bool>> logout() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    if (await sharedPref.remove('user')) return Right(true);
    return Left(DatabaseFailure(code: 505, message: 'Internal Server Error'));
  }

  @override
  Future<Either<AppFailure, T>> sendRequest<T>({
    required MessageLog messageLog,
    required Future<Either<AppFailure, T>> Function() action,
  }) {
    return tryAndCatchTheExpcetions<T>(
      action: action,
      logger: _logger,
      failureMessage:
          messageLog.message ?? 'There was an issue running your request',
    );
  }

  @override
  Future<Either<AppFailure, String?>> fetchUserToken() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    if ((sharedPref.getString('user')) != null) {
      return Right(sharedPref.getString('user') ?? "");
    }
    return Right(null);
  }
}
