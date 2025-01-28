import 'package:flutter_bloc/flutter_bloc.dart';
/// A Cubit that manages the state of a wallet balance toggle.
/// 
/// The state is represented as a boolean:
/// - `false` indicates the balance is not toggled.
/// - `true` indicates the balance is toggled.
/// 
/// Methods:
/// - `toggle(bool hasToggle)`: Updates the state based on the given `hasToggle` value.
/// - `hasToggle`: A getter that returns the current state of the toggle (whether it's on or off).
final class WalletBalanceCubit extends Cubit<bool> {
  WalletBalanceCubit() : super(false);

  // Toggles the wallet balance state based on the provided value.
  void toggle(bool hasToggle) => emit(hasToggle);

  // Returns the current state of the toggle (true or false).
  bool get hasToggle => state;
}
