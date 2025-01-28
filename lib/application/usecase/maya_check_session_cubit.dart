import 'package:dartz/dartz.dart';
import '../../domain/model/abstracts/exceptions/app_failure.dart';
import '../../domain/model/abstracts/maya_services/maya_auth_service.dart';
import '../../domain/model/abstracts/cubits/app_state.dart';
import '../parameters/maya_auth_parameters.dart';

/// `MayaCheckSessionCubit` is a [Cubit] that manages the state related to
/// checking a user's session for authentication.
///
/// This class extends [AppCubit] with a [MayaAuthParameters] as input and a
/// [String] as output, representing the user token or an error message.
///
/// It uses an instance of [AMayaAuthService] to interact with the backend
/// to fetch the user token (session), and returns the result encapsulated
/// in an [Either] type, which will either contain an [AppFailure] if the
/// operation fails, or a [String] (the user token) if successful.
///
/// [MayaCheckSessionCubit] is expected to be called with [MayaAuthParameters],
/// although the current method does not directly use it in the operation.
///
/// **Dependencies:**
/// - [AMayaAuthService] - A service that handles fetching the user session/token.
class MayaCheckSessionCubit extends AppCubit<MayaAuthParameters, String?> {
  MayaCheckSessionCubit({required AMayaAuthService mayaAuthService})
      : _mayaAuthService = mayaAuthService;

  final AMayaAuthService _mayaAuthService;

  /// Overrides the [onMethodCall] method from [AppCubit].
  ///
  /// This method calls [AMayaAuthService.fetchUserToken] to retrieve the user
  /// token, encapsulating the result in an [Either] type to represent success
  /// or failure.
  ///
  /// - **param**: [MayaAuthParameters] - Parameters for authentication
  /// (though not used directly here).
  ///
  /// Returns an [Either<AppFailure, String>] where:
  /// - [AppFailure] represents a failure in fetching the user token.
  /// - [String] represents the successfully fetched user token.
  @override
  Future<Either<AppFailure, String?>> onMethodCall({
    MayaAuthParameters? param,
  }) async {
    return await _mayaAuthService.fetchUserToken();
  }
}
