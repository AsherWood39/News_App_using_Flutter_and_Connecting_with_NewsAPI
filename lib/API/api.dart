import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_using_newsapi_key/Model/bing_image_model/bing_image_model.dart';
import 'package:news_app_using_newsapi_key/Model/news_list_model/news_list_model.dart';

Future<NewsListModel> getAllNews() async {
  final response = await http.get(Uri.parse('http://localhost:3000/news'));

  final result = jsonDecode(response.body) as Map<String, dynamic>;

  return NewsListModel.fromJson(result);
}

Future<NewsListModel> getAllNewsForSlider() async {
  final response = await http.get(
    Uri.parse('http://localhost:3000/slider-news'),
  );

  final result = jsonDecode(response.body) as Map<String, dynamic>;

  return NewsListModel.fromJson(result);
}

Future<NewsListModel> getAllNewsForCategory(String category) async {
  final response = await http.get(
    Uri.parse('http://localhost:3000/category-news'),
  );

  final result = jsonDecode(response.body) as Map<String, dynamic>;

  return NewsListModel.fromJson(result);
}

Future<BingImageModel> loadBingImage() async {
  final response = await http.get(
    Uri.parse(
      'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=en-US',
    ),
  );

  final result = jsonDecode(response.body) as Map<String, dynamic>;

  return BingImageModel.fromJson(result);
}
