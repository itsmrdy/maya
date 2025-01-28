import 'package:dartz/dartz.dart';
import '../../domain/model/entities/maya_transactions_entities.dart';
import '../parameters/maya_transaction_parameters.dart';
import '../../domain/model/abstracts/cubits/app_state.dart';
import '../../domain/model/abstracts/exceptions/app_failure.dart';
import '../../domain/model/abstracts/maya_services/maya_transaction_service.dart';

/// Cubit responsible for posting a transaction in the Maya system.
///
/// The [MayaPostTransactionsCubit] is a part of the application's state management
/// and is specifically designed to handle the business logic of posting a new transaction.
/// It extends from [AppCubit], where the generic parameters are [MayaTransactionParameters]
/// (input data for the transaction) and [bool] (the result of the transaction posting).
///
/// The cubit utilizes the [MayaTransactionService] to interact with the underlying service layer
/// for posting the transaction, handling the success and failure cases accordingly.
///
/// This class provides the following methods:
/// - [onMethodCall]: Overrides the base class method to call the [postTransaction]
///   method from the [MayaTransactionService], passing the provided [MayaTransactionParameters].
///   It returns an [Either] with either an [AppFailure] (on error) or a [bool] indicating the
///   success of the operation (true if the transaction is posted successfully).
///
/// Dependencies:
/// - [MayaTransactionService]: The service used to post transactions.
///
/// Example Usage:
/// - When the user triggers a post transaction action, the cubit calls [onMethodCall]
///   with the required parameters (e.g., userId, transaction details).
/// - It then communicates with the service layer and updates the state based on the result.
final class MayaPostTransactionsCubit
    extends AppCubit<MayaTransactionParameters, MayaTransactionsEntities> {
  final MayaTransactionService _mayaTransactionService;

  MayaPostTransactionsCubit({
    required MayaTransactionService mayaTransactionService,
  }) : _mayaTransactionService = mayaTransactionService;

  @override
  Future<Either<AppFailure, MayaTransactionsEntities>> onMethodCall({
    MayaTransactionParameters? param,
  }) async {
    // Calls the service layer to post the transaction and returns the result.
    return _mayaTransactionService.postTransaction(
      mayaTransactionParameters: param!,
    );
  }
}
