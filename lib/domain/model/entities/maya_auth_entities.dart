// MayaAuthEntities is an entity that represents the result of a successful authentication process.
// It holds the user's token and the date and time the user logged in.
class MayaAuthEntities {
  final String
      userToken; // The token issued to the user after successful authentication
  final DateTime dateTimeLoggedIn; // The date and time when the user logged in

  // Constructor that initializes the userToken and dateTimeLoggedIn.
  // Both fields are required to create an instance of MayaAuthEntities.
  MayaAuthEntities({
    required this.userToken, // The authentication token assigned to the user
    required this.dateTimeLoggedIn, // Timestamp of when the user logged in
  });
}
