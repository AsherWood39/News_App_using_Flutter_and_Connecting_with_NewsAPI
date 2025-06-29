import 'package:flutter/material.dart';
import 'package:news_app_using_newsapi_key/Model/news_list_model/article.dart';
import 'package:news_app_using_newsapi_key/Model/news_list_model/category_model.dart';

ValueNotifier<List<Article>> newsNotifier = ValueNotifier([]);
String? currentUserId;

ValueNotifier<List<CategoryModel>> categoryNotifier = ValueNotifier([
  CategoryModel(categoryName: 'Business', image: 'assets/Business.jpg'),
  CategoryModel(
    categoryName: 'Entertainment',
    image: 'assets/Entertainment.jpeg',
  ),
  CategoryModel(categoryName: 'General', image: 'assets/General.jpeg'),
  CategoryModel(categoryName: 'Health', image: 'assets/Health.jpeg'),
  CategoryModel(categoryName: 'Sports', image: 'assets/Sports.jpeg'),
]);

ValueNotifier<List<Article>> sliderNotifier = ValueNotifier([]);

ValueNotifier<List<Article>> categoryNewsNotifier = ValueNotifier([]);
