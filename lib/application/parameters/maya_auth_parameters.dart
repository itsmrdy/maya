// This class holds the parameters for authentication, specifically the username and password.
// It is typically used for user authentication-related use cases, such as logging in.
class MayaAuthParameters {
  final String username;  // The username input for authentication
  final String password;  // The password input for authentication

  // Constructor to initialize the username and password.
  // Both fields are required to create an instance of MayaAuthParameters.
  MayaAuthParameters({
    required this.username,  // The username to be passed during authentication
    required this.password,  // The password to be passed during authentication
  });
}
