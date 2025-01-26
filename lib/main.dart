import 'package:flutter/material.dart';
import 'application/injectors/injector.dart' as injector;
import 'presentation/theme/themes.dart';
import 'presentation/routes/router.dart';

// Entry point of the application.
// This calls `runApp` to start the Flutter application with MayaApp as the root widget.
void main() => runApp(const MayaApp());

// MayaApp widget is a StatefulWidget, meaning it can hold mutable state
// that can be updated over time.
class MayaApp extends StatefulWidget {
  const MayaApp(
      {super.key}); // Constructor to initialize the widget with a key.

  @override
  State<MayaApp> createState() =>
      _MayaAppState(); // Creates and returns the state object for MayaApp.
}

// _MayaAppState manages the state for MayaApp.
// The state is mutable, which allows us to initialize services or dependencies when the app starts.
class _MayaAppState extends State<MayaApp> {
  @override
  void initState() {
    super.initState();
    // Initializes the service locator (injector) when the app is first created.
    // This might include setting up dependency injections or initializing services.
    injector.initializer();
  }

  // The build method is called when the widget needs to rebuild.
  // This widget represents the root of your application, and it configures
  // routing, theming, and other essential settings for the app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // The routerConfig property connects your app to a router,
      // enabling advanced navigation and routing features.
      routerConfig: router,

      // Disables the debug banner shown in the top right corner in debug mode.
      debugShowCheckedModeBanner: false,

      // Sets the app's theme by applying the custom theme from the Themes class.
      // `mayaTheme` is likely a predefined theme that defines colors, fonts, etc.
      theme: Themes.appTheme.mayaTheme,
    );
  }
}
