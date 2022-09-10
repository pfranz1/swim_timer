import 'package:json_annotation/json_annotation.dart';

enum Stroke {
  @JsonValue("free")
  FREE_STYLE,
  @JsonValue("back")
  BACK_STROKE,
  @JsonValue("breast")
  BREAST_STROKE,
  @JsonValue("fly")
  BUTTERFLY,
}
