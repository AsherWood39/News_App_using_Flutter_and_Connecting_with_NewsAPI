// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app_using_newsapi_key/Core/core.dart';
import 'package:news_app_using_newsapi_key/Infrastructure/db_functions.dart';
import 'package:news_app_using_newsapi_key/Model/news_list_model/article.dart';
import 'package:news_app_using_newsapi_key/Model/news_list_model/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  // UserModel user;
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getAllNewsInNotifier();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Flutter'),
              Text(
                'News',
                style: TextStyle(
                  color: Colors.red.shade200,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          elevation: 16.0,
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 70,
                child: ValueListenableBuilder(
                  valueListenable: categoryNotifier,
                  builder: (context, newCategory, _) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var categoryData = newCategory[index];

                        return CategoryTile(
                          image: categoryData.image,
                          categoryName: categoryData.categoryName,
                        );
                      },
                      itemCount: newCategory.length,
                    );
                  },
                ),
              ),
              ValueListenableBuilder(
                valueListenable: sliderNotifier,
                builder: (context, newSlider, _) {
                  return CarouselSlider.builder(
                    itemCount: newSlider.length,
                    itemBuilder: (context, index, realIndex) {
                      final sliderData = newSlider[index];

                      return buildImage(
                        context,
                        sliderData.sliderImage!,
                        index,
                        sliderData.sliderName!,
                      );
                    },
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(
    BuildContext context,
    String urlImage,
    int index,
    String name,
  ) => Container(
    child: Image.asset(
      urlImage,
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width * .9,
    ),
  );

  String _truncateText(String text, int maxChars) {
    if (text.length <= maxChars) return text;
    return text.substring(0, maxChars);
  }

  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  const CategoryTile({super.key, this.image, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              image,
              width: 120,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 120,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Center(
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
