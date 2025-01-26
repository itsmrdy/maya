import '../../../../application/parameters/maya_auth_parameters.dart';

abstract class ADatabase {
  void populate();
  Future<bool> loadUser({required MayaAuthParameters authParameters});
  Future<void> copyDataBaseFromAsset();
}
