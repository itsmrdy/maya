// MayaAppScaffold is a reusable widget that wraps a Scaffold with a custom app bar (MayaAppBar)
// and allows you to pass in a child widget to be displayed as the body of the scaffold.
import 'package:flutter/material.dart';
import 'maya_app_bar.dart';

class MayaAppScaffold<T> extends StatelessWidget {
  const MayaAppScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MayaAppBar<T>(),  // Custom app bar for the Maya app
      body: child,           // Body of the scaffold, passed as a parameter
    );
  }
}