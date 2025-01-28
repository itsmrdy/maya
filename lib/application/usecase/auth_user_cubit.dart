import 'package:dartz/dartz.dart';
import '../../domain/model/abstracts/cubits/app_state.dart';
import '../../domain/model/abstracts/exceptions/app_failure.dart';
import '../../domain/model/abstracts/maya_services/maya_auth_service.dart';
import '../../domain/model/entities/maya_user_entities.dart';
import '../parameters/maya_auth_parameters.dart';

final class AuthUserCubit extends AppCubit<MayaAuthParameters, MayaUserEntities> {
  AuthUserCubit({
    required AMayaAuthService mayAuthService,
  }) : _mayaAuthService = mayAuthService;

  final AMayaAuthService _mayaAuthService;

  @override
  Future<Either<AppFailure, MayaUserEntities>> onMethodCall({
    MayaAuthParameters? param,
  }) async =>
      await _mayaAuthService.login(authParameters: param!);
}
