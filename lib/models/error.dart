import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'error.g.dart';

@JsonSerializable()
@HiveType(typeId: 7)
class Error extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String type;

  @HiveField(2)
  String text;

  Error({
    required this.id,
    required this.type,
    required this.text,
  });

  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
