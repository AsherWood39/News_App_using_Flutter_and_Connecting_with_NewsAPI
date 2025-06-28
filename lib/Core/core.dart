import 'package:flutter/material.dart';
import 'package:news_app_using_newsapi_key/Model/news_list_model/article.dart';
import 'package:news_app_using_newsapi_key/Model/news_list_model/category_model.dart';
import 'package:news_app_using_newsapi_key/Model/news_list_model/slider_model.dart';

ValueNotifier<List<Article>> newsNotifier = ValueNotifier([]);
String? currentUserId;

ValueNotifier<List<CategoryModel>> categoryNotifier = ValueNotifier([
  CategoryModel(
    categoryName: 'Entertainment',
    image: 'assets/Entertainment.jpeg',
  ),
  CategoryModel(categoryName: 'Business', image: 'assets/Business.jpg'),
  CategoryModel(categoryName: 'General', image: 'assets/General.jpeg'),
  CategoryModel(categoryName: 'Health', image: 'assets/Health.jpeg'),
  CategoryModel(categoryName: 'Sports', image: 'assets/Sports.jpeg'),
]);

ValueNotifier<List<SliderModel>> sliderNotifier = ValueNotifier([
  SliderModel(sliderName: 'Business', sliderImage: 'assets/Business.jpg'),
  SliderModel(
    sliderName: 'Entertainment',
    sliderImage: 'assets/Entertainment.jpeg',
  ),
  SliderModel(sliderName: 'General', sliderImage: 'assets/General.jpeg'),
  SliderModel(sliderName: 'Health', sliderImage: 'assets/Health.jpeg'),
  SliderModel(sliderName: 'Sports', sliderImage: 'assets/Sports.jpeg'),
]);
