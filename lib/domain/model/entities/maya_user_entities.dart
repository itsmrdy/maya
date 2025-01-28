/// Represents a user entity in the application with essential user details.
///
/// This class stores basic information about a user, including their username,
/// password, and account balance. It is used to model a user object in the system
/// and can be used for various operations such as authentication, account management,
/// and balance tracking.
class MayaUserEntities {
  /// The username of the user. This serves as the user's unique identifier in the system.
  final String username;

  /// The password of the user. This is used for authentication. It is important to
  /// store the password securely (e.g., hash it before storage).
  final String password;

  /// The current balance of the user's account, represented as a [double].
  /// This value can be used to track user funds or account balance.
  final double balance;


  final int userid;

  /// Creates a new instance of [MayaUserEntities] with the given [username], [password],
  /// and [balance]. All fields are required to initialize the object.
  ///
  /// [username] - The unique identifier for the user.
  /// [password] - The user's password (make sure to hash it before storage).
  /// [balance] - The user's account balance.
  MayaUserEntities({
    required this.username,
    required this.password,
    required this.balance,
    required this.userid,
  });
}