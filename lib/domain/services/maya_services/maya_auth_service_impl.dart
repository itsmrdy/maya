import 'package:codenic_logger/codenic_logger.dart';
import 'package:dartz/dartz.dart';
import '../../../application/parameters/maya_auth_parameters.dart';
import '../../../infrastracture/database/maya_database.dart';
import '../../model/abstracts/exceptions/app_failure.dart';
import '../../model/abstracts/maya_services/maya_auth_service.dart';
import '../../model/entities/maya_auth_entities.dart';
import '../../model/functions/try_and_catch_the_exception.dart';
import '../../model/interfaces/http_request.dart';
import '../failures/database_failure.dart';

class MayaAuthServiceImpl extends AMayaAuthService implements IHttpRequest {
  MayaAuthServiceImpl({
    required MayaDatabase database,
    required CodenicLogger logger,
  })  : _mayaDatabase = database,
        _logger = logger;

  final MayaDatabase _mayaDatabase;
  final CodenicLogger _logger;

  @override
  Future<Either<AppFailure, MayaAuthEntities>> login({
    required MayaAuthParameters authParameters,
  }) async {
    return sendRequest<MayaAuthEntities>(
      messageLog: MessageLog(id: 'authenticate-user'),
      action: () async {
        final isUserExist = await _mayaDatabase.loadUser(
          authParameters: authParameters,
        );
        if (isUserExist) {}
        return Left(DatabaseFailure(
            code: 404, message: 'User not found or exist in database'));
      },
    );
  }

  @override
  Future<Either<AppFailure, bool>> logout() async {
    throw UnimplementedError();
  }

  @override
  Future<Either<AppFailure, T>> sendRequest<T>({
    required MessageLog messageLog,
    required Future<Either<AppFailure, T>> Function() action,
  }) {
    return tryAndCatchTheExpcetions(
      action: action,
      logger: _logger,
      failureMessage: messageLog.message!,
    );
  }
}
