part of 'themes.dart';

class AppTheme {
  AppTheme._();

  static AppTheme get instance => AppTheme._();
  static const double xxs = 4,
      xs = 8,
      sm = 16,
      medium = 24,
      large = 32,
      xlarge = 64;
  static Color defaultColor = Color(0xfff0f2f5);
  static Color baseColor = Colors.white;
  static Color greyColor = Colors.grey;

  ThemeData get mayaTheme {
    return ThemeData(
      useMaterial3: false,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: baseColor,
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: const Color.fromARGB(255, 235, 235, 235), width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(AppTheme.medium),
          ),
        ),
      ),
      scaffoldBackgroundColor: AppTheme.baseColor,
    );
  }
}
