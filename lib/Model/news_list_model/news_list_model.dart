import 'package:json_annotation/json_annotation.dart';

import 'article.dart';

part 'news_list_model.g.dart';

@JsonSerializable()
class NewsListModel {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'totalResults')
  int? totalResults;
  @JsonKey(name: 'articles')
  List<Article>? articles;

  NewsListModel({this.status, this.totalResults, this.articles});

  factory NewsListModel.fromJson(Map<String, dynamic> json) {
    return _$NewsListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewsListModelToJson(this);
}
