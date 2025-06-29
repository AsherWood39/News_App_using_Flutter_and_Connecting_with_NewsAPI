import 'package:json_annotation/json_annotation.dart';

import 'image.dart';

part 'bing_image_model.g.dart';

@JsonSerializable()
class BingImageModel {
  @JsonKey(name: 'images')
  List<Image>? images;

  BingImageModel({this.images});

  factory BingImageModel.fromJson(Map<String, dynamic> json) {
    return _$BingImageModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BingImageModelToJson(this);
}
