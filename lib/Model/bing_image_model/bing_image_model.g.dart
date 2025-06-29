// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bing_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BingImageModel _$BingImageModelFromJson(Map<String, dynamic> json) =>
    BingImageModel(
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BingImageModelToJson(BingImageModel instance) =>
    <String, dynamic>{'images': instance.images};
