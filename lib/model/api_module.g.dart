// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiModule _$ApiModuleFromJson(Map<String, dynamic> json) => ApiModule(
      status: json['status'] as String?,
      totalResults: json['totalResults'] as int?,
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => MyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApiModuleToJson(ApiModule instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  writeNotNull('totalResults', instance.totalResults);
  writeNotNull('articles', instance.articles);
  return val;
}
