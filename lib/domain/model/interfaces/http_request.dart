import 'package:codenic_logger/codenic_logger.dart';
import 'package:dartz/dartz.dart';
import '../abstracts/exceptions/app_failure.dart';
// Interface for handling HTTP requests in a generic way
abstract interface class IHttpRequest {
  // Abstract method that performs an HTTP request
  // Takes a log message and an action that represents the HTTP request logic
  Future<Either<AppFailure, T>> sendRequest<T>({
    required MessageLog messageLog,  // The log message to track the request
    required Future<Either<AppFailure, T>> Function() action,  // The action to perform the actual HTTP request
  }) async {
    // Throwing UnimplementedError as this is an abstract method
    throw UnimplementedError();
  }
}

