import 'package:maya/domain/model/abstracts/network/http_client.dart';
import 'package:maya/domain/model/valueobjects/maya_auth_transactions_dto.dart';

class MayaHttpClientMock implements HttpClient {
  final List<MayaAuthTransactionsDTO> transactionsList = [
    MayaAuthTransactionsDTO(
      userId: 1,
      id: 201,
      title: 'Money Sent - Successful',
      body: 'You successfully sent \$500 to user 2.',
    ),
    MayaAuthTransactionsDTO(
      userId: 2,
      id: 202,
      title: 'Money Sent - Failed',
      body: 'The transaction failed. Please check your account balance.',
    ),
    MayaAuthTransactionsDTO(
      userId: 3,
      id: 203,
      title: 'Money Sent - Pending',
      body: 'Your \$100 transfer is pending. Please wait for confirmation.',
    ),
    MayaAuthTransactionsDTO(
      userId: 4,
      id: 204,
      title: 'Money Sent - Refund Issued',
      body: 'Your \$200 transfer was refunded due to a technical error.',
    ),
    MayaAuthTransactionsDTO(
      userId: 5,
      id: 205,
      title: 'Money Sent - Partially Successful',
      body:
          'You sent \$1000, but only \$500 was successfully transferred due to an issue with the recipient\'s account.',
    ),
  ];

  @override
  Future<List<MayaAuthTransactionsDTO>> getTransactions() async {
    return transactionsList;
  }

  @override
  Future<MayaAuthTransactionsDTO?> postTransactions(
    Map<String, dynamic> transactions,
  ) async {
    if (transactions.isNotEmpty) {
      transactionsList.add(
        MayaAuthTransactionsDTO.fromJson(transactions),
      );
      return MayaAuthTransactionsDTO.fromJson(transactions);
    }
    return MayaAuthTransactionsDTO.fromJson({});
  }
}
