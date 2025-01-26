import 'package:dartz/dartz.dart';
import '../../../../application/parameters/maya_auth_parameters.dart';
import '../exceptions/app_failure.dart';
import '../../entities/maya_auth_entities.dart';

/// Abstract class defining the contract for authentication services in the application.
/// It provides methods for logging in and logging out users.
/// The login method expects authentication parameters (username and password)
/// and returns either a failure or authentication details (such as a user token).
/// The logout method returns a success or failure indication of the logout process.
///
/// Classes implementing this interface are responsible for handling the actual
/// authentication logic, such as making network requests, storing session data, etc.
/// This abstraction allows for flexibility in changing the underlying implementation
/// (e.g., using a different API or local authentication storage) without affecting other parts of the app.

abstract class AMayaAuthService {
  /// Attempts to log in a user with the provided authentication parameters.
  ///
  /// Returns:
  /// - [Right(MayaAuthEntities)] if the login is successful (containing user token and login time).
  /// - [Left(AppFailure)] if the login fails (e.g., invalid credentials, network error).
  Future<Either<AppFailure, MayaAuthEntities>> login({
    required MayaAuthParameters
        authParameters, // Parameters containing username and password
  });

  /// Logs out the current user.
  ///
  /// Returns:
  /// - [Right(true)] if the logout is successful.
  /// - [Left(AppFailure)] if the logout fails (e.g., no user is logged in, network error).
  Future<Either<AppFailure, bool>> logout();
}
