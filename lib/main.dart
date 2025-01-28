import 'package:flutter/material.dart';
import 'application/injectors/injector.dart' as injector;
import 'presentation/theme/themes.dart';
import 'presentation/routes/router.dart';

// Entry point of the application.
// This calls `runApp` to start the Flutter application with MayaApp as the root widget.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector.initializer();

  runApp(const MayaApp());
}

// _MayaAppState manages the state for MayaApp.
// The state is mutable, which allows us to initialize services or dependencies when the app starts.
class MayaApp extends StatelessWidget {
  const MayaApp({super.key});

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
