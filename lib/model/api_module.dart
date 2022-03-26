import 'package:json_annotation/json_annotation.dart';
import 'package:quantumit/model/mymodel.dart';

part 'api_module.g.dart';
@JsonSerializable(genericArgumentFactories: true,includeIfNull: false)

class ApiModule{

  String? status;
  int? totalResults;
  List<MyModel>? articles;

  ApiModule({this.status, this.totalResults, this.articles});

  factory ApiModule.fromJson(Map<String, dynamic> json, MyModel Function(dynamic data) param1) =>
      _$ApiModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ApiModuleToJson(this);

/*  factory DataResponse.fromJson(Map<String, dynamic> json, TModel Function(Object? json) fromJsonT,) => _$DataResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(TModel value) toJsonT) => _$DataResponseToJson(this, toJsonT);*/
}