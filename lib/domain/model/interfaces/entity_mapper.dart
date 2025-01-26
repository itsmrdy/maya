/// An interface class for mapping objects to entity types.
///
/// This class defines a single method `toEntity()` which is intended to be implemented
/// by subclasses to map the current object (which could be a DTO, model, or any other type)
/// into an entity type `T`. The `toEntity()` method should be overridden in subclasses to
/// provide the actual transformation logic.
///
/// **Example Usage**:
/// ```dart
/// class UserDTO implements EntityMapper<User> {
///   final String username;
///   final String email;
///
///   UserDTO({required this.username, required this.email});
///
///   @override
///   User toEntity() {
///     return User(username: username, email: email);
///   }
/// }
/// ```
abstract interface class IEntityMapper<T> {
  
  /// Maps the current object to an entity of type `T`.
  ///
  /// This method should be overridden to provide the logic for converting
  /// the object to an entity (e.g., a domain model).
  T toEntity() => throw UnimplementedError(); 
}
