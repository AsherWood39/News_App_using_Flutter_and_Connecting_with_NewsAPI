// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsListModel _$NewsListModelFromJson(Map<String, dynamic> json) =>
    NewsListModel(
      status: json['status'] as String?,
      totalResults: (json['totalResults'] as num?)?.toInt(),
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsListModelToJson(NewsListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };
