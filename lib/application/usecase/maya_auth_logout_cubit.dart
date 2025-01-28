import 'package:dartz/dartz.dart';
import '../../domain/model/abstracts/exceptions/app_failure.dart';
import '../../domain/model/abstracts/cubits/app_state.dart';
import '../../domain/model/abstracts/maya_services/maya_auth_service.dart';
import '../parameters/maya_auth_parameters.dart';

/// `MayaAuthLogoutCubit` is a [Cubit] that manages the state related to
/// logging out the user from the authentication system.
///
/// This class extends [AppCubit] with [MayaAuthParameters] as input and a 
/// [bool] as output, representing whether the logout operation was successful
/// or not (true for success, false for failure).
///
/// It uses an instance of [AMayaAuthService] to interact with the backend 
/// and perform the logout operation, and returns the result encapsulated 
/// in an [Either] type, which will either contain an [AppFailure] if the 
/// operation fails, or a [bool] indicating success or failure.
///
/// **Dependencies:**
/// - [AMayaAuthService] - A service that handles logging out the user.
class MayaAuthLogoutCubit extends AppCubit<MayaAuthParameters, bool> {
  MayaAuthLogoutCubit({required AMayaAuthService mayaAuthService})
      : _mayaAuthService = mayaAuthService;

  final AMayaAuthService _mayaAuthService;

  /// Overrides the [onMethodCall] method from [AppCubit].
  /// 
  /// This method calls [AMayaAuthService.logout] to log the user out,
  /// encapsulating the result in an [Either] type to represent success 
  /// or failure.
  ///
  /// - **param**: [MayaAuthParameters] - Parameters for logout (though 
  /// not used directly in the method).
  /// 
  /// Returns an [Either<AppFailure, bool>] where:
  /// - [AppFailure] represents any failure encountered during logout.
  /// - [bool] represents the success of the logout operation (true if 
  /// logout was successful, false otherwise).
  @override
  Future<Either<AppFailure, bool>> onMethodCall({
    MayaAuthParameters? param,
  }) async {
    return await _mayaAuthService.logout();
  }
}