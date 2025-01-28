import 'package:dartz/dartz.dart';
import '../../../../application/parameters/maya_transaction_parameters.dart';
import '../../entities/maya_transactions_entities.dart';
import '../exceptions/app_failure.dart';

/// Abstract service class for interacting with Maya transactions.
/// 
/// This class defines the contract for services that handle transactions
/// in the Maya system. It includes methods for fetching and posting
/// transactions. The service layer is responsible for business logic
/// and typically interacts with repositories or external APIs.
/// 
/// It exposes the following methods:
/// - [getTransactions]: Fetches a list of Maya transactions. Returns an
///   [Either] with either an [AppFailure] (if an error occurs) or a list
///   of [MayaTransactionsEntities] representing the transaction data.
/// - [postTransaction]: Posts a new transaction to the system. It accepts
///   [MayaTransactionParameters] as input (which includes details like
///   userId, id, title, and body) and returns an [Either] with either
///   an [AppFailure] (if an error occurs) or a boolean indicating the
///   success of the operation (true if the transaction was posted successfully).
/// 
/// The service layer is a key part of your application's domain logic,
/// ensuring that data is processed and handled consistently across
/// different parts of the app. Any failure in processing will be
/// wrapped in an [AppFailure] object for proper error handling.
abstract class MayaTransactionService {
  /// Fetches a list of Maya transactions.
  /// 
  /// Returns:
  /// - [Left] with an [AppFailure] if there is an error fetching the transactions.
  /// - [Right] with a list of [MayaTransactionsEntities] if successful.
  Future<Either<AppFailure, List<MayaTransactionsEntities>>> getTransactions();

  /// Posts a new transaction to the system.
  /// 
  /// Accepts a [MayaTransactionParameters] object containing transaction details.
  /// 
  /// Returns:
  /// - [Left] with an [AppFailure] if the transaction posting fails.
  /// - [Right] with a [bool] indicating whether the transaction was posted successfully.
  Future<Either<AppFailure, MayaTransactionsEntities>> postTransaction({
    required MayaTransactionParameters mayaTransactionParameters,
  });
}