// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maya_auth_transactions_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MayaAuthTransactionsDTO _$MayaAuthTransactionsDTOFromJson(
        Map<String, dynamic> json) =>
    MayaAuthTransactionsDTO(
      userId: (json['userId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$MayaAuthTransactionsDTOToJson(
        MayaAuthTransactionsDTO instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
