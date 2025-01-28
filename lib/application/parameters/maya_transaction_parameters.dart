/// Represents the parameters associated with a Maya transaction.
///
/// This class encapsulates the key properties needed to describe a
/// transaction. It is designed to be used as input or parameters
/// for creating or managing a transaction in the Maya system.
///
/// It has the following properties:
/// - [userId]: The ID of the user initiating or associated with the transaction.
/// - [id]: The unique identifier for the transaction.
/// - [title]: The title or summary of the transaction.
/// - [body]: A detailed description or body content related to the transaction.
///
/// This class is typically used as a data structure to hold transaction
/// details before performing operations like sending to an API,
/// storing in a database, or any other logic that involves transaction
/// information.
class MayaTransactionParameters {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  MayaTransactionParameters({
    required this.userId,
    this.id,
    this.title,
    this.body,
  });
}
