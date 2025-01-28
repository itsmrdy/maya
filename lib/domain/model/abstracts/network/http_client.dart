import 'package:dio/dio.dart';
import 'package:maya/domain/model/valueobjects/maya_auth_transactions_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'http_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')

abstract class HttpClient {
  factory HttpClient(Dio dio, {String? baseUrl}) = _HttpClient;

  @GET('/posts')
  Future<List<MayaAuthTransactionsDTO>> getTransactions();

  @POST('/posts')
  Future<MayaAuthTransactionsDTO?> postTransactions(Map<String, dynamic> transactions);
}
