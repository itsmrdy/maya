import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../abstracts/cubits/app_state.dart';

/// This extension on `AppState` helps reduce boilerplate code when working with
/// state-driven UI in Flutter. It simplifies the common pattern of responding
/// to different states (like loading, success, or failure) by providing reusable
/// methods for rendering appropriate widgets and handling state transitions.
///
/// It supports both a widget-based approach to state handling (`useBloc`) and
/// a function-based approach for invoking actions on specific states (`call`).
///
/// This is particularly useful for handling common use cases like:
/// - Displaying a loading indicator while waiting for data.
/// - Showing a success state when data is loaded.
/// - Handling failure states when something goes wrong.

extension State<Params, RType> on AppState {
  /// A widget-based approach for handling different states and rendering
  /// the appropriate widget based on the current `AppState`.
  ///
  /// - `processing`: Widget to show when the state is still loading.
  /// - `loaded`: Widget to show when data has been successfully loaded.
  /// - `loadFailed`: Widget to show when the load operation has failed.
  /// - `rebuild`: Optional function for triggering rebuilds (not currently used in this example).
  Widget useBloc<T extends AppCubit<Params, ReturnType>, ReturnType>({
    required BuildContext context,
    required Widget Function() processing, // Widget for loading state
    required Widget Function(ReturnType? data)
        loaded, // Widget for success state
    required dynamic Function() loadFailed, // Widget for failure state
    dynamic Function()? rebuild, // Optional, not currently used
  }) {
    switch (this) {
      case AppReturnSuccess _:
        return loaded
            .call(context.read<T>().value); // Return loaded widget with data
      case AppRunning _:
        return processing.call(); // Return loading widget
      default:
        return loadFailed.call(); // Return failure widget
    }
  }

  /// A function-based approach to trigger actions based on the current state.
  ///
  /// - `hasListened`: Function to call when the state is a success (`AppReturnSuccess`).
  /// - `hasFailure`: Function to call when the state is a failure or running.
  void foldBloc<T extends AppCubit<Params, ReturnType>, ReturnType>({
    required BuildContext context,
    required void Function(ReturnType? data) hasListened, // Action on success
    required void Function() hasFailure, // Action on failure
  }) {
    if (this is AppReturnSuccess) {
      hasListened.call(context.read<T>().value); // Call success handler
      return;
    } else if (this is AppReturnFailure){
      hasFailure.call(); // Call failure handler
      return;
    }
  }
}
