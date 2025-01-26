import 'package:dartz/dartz.dart';

/// Extension methods for the `Either<L, R>` type from the `dartz` package.
///
/// This extension adds helper methods to extract the `left` and `right` values
/// from an `Either<L, R>` instance. If the `Either` contains a `Left` value,
/// the `left()` method returns it, and if it contains a `Right` value, the
/// `right()` method returns it.
///
/// These methods simplify working with `Either` by reducing boilerplate code
/// for handling the different possible values.

extension DartzExtensions<L, R> on Either<L, R> {
  
  /// Returns the `Right` value if the `Either` is a `Right`, otherwise throws
  /// a `StateError` with the `Left` value's string representation.
  R right() => fold(
    (L left) => throw StateError(left.toString()),  // Handle Left case
    (R right) => right,  // Return Right value
  );
  
  /// Returns the `Left` value if the `Either` is a `Left`, otherwise throws
  /// a `StateError` with the `Right` value's string representation.
  L left() => fold(
    (L left) => left,  // Return Left value
    (R right) => throw StateError(right.toString()),  // Handle Right case
  );
}
