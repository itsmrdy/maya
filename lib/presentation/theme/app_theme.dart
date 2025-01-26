part of 'themes.dart';

class AppTheme {
  AppTheme._();

  static AppTheme get instance => AppTheme._();

  ThemeData get mayaTheme {
    return ThemeData(
      useMaterial3: false,
    );
  }
}
