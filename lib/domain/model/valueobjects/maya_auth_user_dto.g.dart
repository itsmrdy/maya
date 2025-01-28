// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maya_auth_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MayaAuthUserDto _$MayaAuthUserDtoFromJson(Map<String, dynamic> json) =>
    MayaAuthUserDto(
      username: json['username'] as String,
      password: json['password'] as String,
      balance: (json['balance'] as num).toDouble(),
      userid: (json['userid'] as num).toInt(),
    );

Map<String, dynamic> _$MayaAuthUserDtoToJson(MayaAuthUserDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'userid': instance.userid,
      'balance': instance.balance,
    };
