import '../entities/maya_user_entities.dart';
import '../interfaces/entity_mapper.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class MayaAuthUserDto implements IEntityMapper<MayaUserEntities> {
  final String username, password;
  final DateTime dateTimeOfLoggedIn;

  const MayaAuthUserDto({
    required this.username,
    required this.password,
    required this.dateTimeOfLoggedIn,
  });

  @override
  MayaUserEntities toEntity() {
    throw UnimplementedError();
  }
}
