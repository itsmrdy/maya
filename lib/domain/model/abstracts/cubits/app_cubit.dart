part of 'app_state.dart';

/// A base class for managing app state in a BLoC (Business Logic Component) architecture using Cubit.
/// This class is designed to handle asynchronous operations, manage state transitions,
/// and ensure that state changes occur only when the current task is finished.
///
/// [Params] is the type of the parameter that the `dispatch` method takes (e.g., request parameters).
/// [ReturnValue] is the type of the result returned from the asynchronous method call (e.g., data, object, etc.).
abstract class AppCubit<Params, ReturnValue> extends Cubit<AppState> {
  AppCubit() : super(InitialAppState()); // Start with the initial state

  // Abstract method to be implemented by subclasses to handle specific business logic.
  // It performs the actual method call with the provided parameters and returns a result or failure.
  Future<Either<AppFailure, ReturnValue>> onMethodCall({Params? param});

  ReturnValue?
      _value; // Holds the value resulting from the method call (if available)

  // Getter to access the current value. It assumes the value is never null when accessed.
  ReturnValue get value => _value!;

  int _runIndicator =
      0; // Indicator to check if a task is running to prevent overlapping executions

  /// Dispatches a request to execute a method with the provided parameters.
  /// Ensures that only one asynchronous task is running at a time.
  ///
  /// - First, it ensures that the current task is running asynchronously (`ensureAsync`).
  /// - If the cubit is already closed or if another task is already running, it prevents further execution.
  /// - Then, it emits the `AppRunning` state to indicate the process is ongoing.
  /// - After that, it calls the business logic via `onMethodCall`.
  /// - Based on the result, it either emits a failure state (`AppReturnFailure`) or a success state (`AppReturnSuccess`).
  ///
  /// [param] is the parameter passed to the business logic.
  Future<void> dispatch({Params? param}) async {
    // Ensure the current task is asynchronous
    await ensureAsync();

    // If the cubit is closed, we stop further execution
    if (isClosed) {
      if (kDebugMode) print('Cubit with $param is already closed');
      return;
    }

    // Prevent dispatching a new task if one is already running
    if (_runIndicator > 0) {
      if (kDebugMode) print('State is already running');
      return;
    }

    // Emit the "AppRunning" state, indicating that a process is currently in progress
    emit(AppRunning(param: param));

    // Mark the task as running
    _runIndicator++;

    // Call the business logic and capture the result
    final Either<AppFailure, ReturnValue> result =
        await onMethodCall(param: param);

    // Handle the result of the method call
    result.fold(
      // If the result is a failure, emit the failure state
      (AppFailure failure) {
        _runIndicator = 0;
        emit(AppReturnFailure<Params>(failure: failure, param: param as Params));
      },
      // If the result is successful, store the value and emit the success state
      (ReturnValue result) {
        _value = result;
        // Reset the run indicator to allow further tasks
        _runIndicator = 0;

        // Emit the success state
        emit(AppReturnSuccess(result: result));
      },
    );
  }

  @override
  // Overriding the close method to clean up resources before the cubit is closed
  Future<void> close() async {
    if (isClosed) return; // Prevent unnecessary close if already closed
    _value = null; // Nullify the stored value to release memory
    super.close(); // Call the superclass's close method
  }
}
