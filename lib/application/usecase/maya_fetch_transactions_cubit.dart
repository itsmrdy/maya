import 'package:dartz/dartz.dart';
import '../parameters/maya_transaction_parameters.dart';
import '../../domain/model/abstracts/cubits/app_state.dart';
import '../../domain/model/abstracts/exceptions/app_failure.dart';
import '../../domain/model/entities/maya_transactions_entities.dart';

import '../../domain/model/abstracts/maya_services/maya_transaction_service.dart';

/// Cubit responsible for fetching Maya transactions from the service layer.
///
/// The [MayaFetchTransactionsCubit] is part of the application's state management system,
/// specifically tasked with handling the business logic for retrieving transactions
/// associated with a specific user. It extends from [AppCubit], where the generic parameters
/// are [MayaTransactionParameters] (input data, including user ID) and [List<MayaTransactionsEntities>]
/// (the result containing the fetched transactions).
///
/// This cubit interacts with the [MayaTransactionService] to fetch the list of transactions.
/// It expects a [MayaTransactionParameters] object containing at least a [userId] and uses this to
/// retrieve the user's transaction data. It handles success and failure cases by returning an [Either]
/// type that either contains a [List<MayaTransactionsEntities>] (on success) or an [AppFailure] (on error).
///
/// The following method is provided:
/// - [onMethodCall]: Overrides the base class method to call the [getTransactions] method from
///   the [MayaTransactionService], passing the user ID from the [MayaTransactionParameters].
///   The result is a list of [MayaTransactionsEntities] or an [AppFailure] if an error occurs.
///
/// Dependencies:
/// - [MayaTransactionService]: The service used to fetch the user's transactions.
///
/// Example Usage:
/// - When the user requests their transaction history, the cubit calls [onMethodCall] with the
///   appropriate [MayaTransactionParameters] (e.g., the user's ID). It then communicates with the
///   service layer to fetch the transactions, returning either a list of transactions or an error.
final class MayaFetchTransactionsCubit extends AppCubit<
    MayaTransactionParameters, List<MayaTransactionsEntities>> {
  final MayaTransactionService _mayaTransactionService;

  MayaFetchTransactionsCubit({
    required MayaTransactionService mayaTransactionService,
  }) : _mayaTransactionService = mayaTransactionService;

  @override
  Future<Either<AppFailure, List<MayaTransactionsEntities>>> onMethodCall({
    MayaTransactionParameters? param,
  }) {
    // Calls the service layer to fetch transactions based on userId from the parameters.
    return _mayaTransactionService.getTransactions();
  }
}
