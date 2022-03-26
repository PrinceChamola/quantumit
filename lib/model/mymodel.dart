
import 'package:json_annotation/json_annotation.dart';

part 'mymodel.g.dart';
@JsonSerializable(includeIfNull: false, explicitToJson: true)
class MyModel{
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;
  Object? source;

  MyModel(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.source
      });

  factory MyModel.fromJson(Map<String, dynamic> json) =>
      _$MyModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyModelToJson(this);

}