import '../exceptions/app_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../functions/ensure_async.dart';

///In this file located the global state of the app
///where a developer can use it to handle application states

part 'app_cubit.dart';

/// The base class for all app states.
/// It allows for different types of states (running, success, failure) to be represented in the app.
sealed class AppState {
  const AppState();
}

/// Represents the initial state of the app or feature.
/// This state is usually emitted before any operations have begun.
final class InitialAppState extends AppState {}

/// Represents the state where an operation is currently running.
/// It carries the [param] to keep track of what operation is in progress.
final class AppRunning<Params> extends AppState {
  const AppRunning({required Params param});
}

/// Represents a successful state where an operation has completed and returned a result.
/// It holds the result of the operation (of type [ReturnValue]).
final class AppReturnSuccess<ReturnValue> extends AppState {
  const AppReturnSuccess({required ReturnValue result});
}

/// Represents a failure state where an operation has failed.
/// It holds the [failure] details (of type [AppFailure]) and the [param] associated with the failed operation.
final class AppReturnFailure<Params> extends AppState {
  const AppReturnFailure({required AppFailure failure, required Params param});
}
