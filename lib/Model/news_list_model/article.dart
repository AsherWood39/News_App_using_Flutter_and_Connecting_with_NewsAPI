import 'package:json_annotation/json_annotation.dart';

import 'source.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  @JsonKey(name: 'source')
  Source? source;
  @JsonKey(name: 'author')
  String? author;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'urlToImage')
  String? urlToImage;
  @JsonKey(name: 'publishedAt')
  String? publishedAt;
  @JsonKey(name: 'content')
  String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return _$ArticleFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
