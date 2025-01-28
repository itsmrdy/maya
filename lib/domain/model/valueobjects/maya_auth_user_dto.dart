import '../entities/maya_user_entities.dart';
import '../interfaces/entity_mapper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'maya_auth_user_dto.g.dart';

@JsonSerializable()
class MayaAuthUserDto implements IEntityMapper<MayaUserEntities> {
  final String username, password;
  final int userid;
  final double balance;

  MayaAuthUserDto({
    required this.username,
    required this.password,
    required this.balance,
    required this.userid,
  }); // Default to DateTime.now() if null

  /// Connect the generated [_$MayaAuthUserDtoFromJson] function to the `fromJson`
  /// factory.
  factory MayaAuthUserDto.fromJson(Map<String, dynamic> json) =>
      _$MayaAuthUserDtoFromJson(json);

  /// Connect the generated [_$MayaAuthUserDtoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MayaAuthUserDtoToJson(this);

  @override
  MayaUserEntities toEntity() {
    return MayaUserEntities(
      username: username,
      password: password,
      balance: balance,
      userid: userid,
    );
  }
}
