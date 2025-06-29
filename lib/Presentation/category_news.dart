// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:news_app_using_newsapi_key/Core/core.dart';
import 'package:news_app_using_newsapi_key/Infrastructure/db_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class CategoryNews extends StatelessWidget {
  String? categoryName;

  CategoryNews({required this.categoryName, super.key});

  @override
  Widget build(BuildContext context) {
    getAllNewsInNotifier(categoryName);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(categoryName!),
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
          child: ValueListenableBuilder(
            valueListenable: categoryNewsNotifier,
            builder: (context, newCategoryData, child) {
              if (newCategoryData.isEmpty) {
                return Center(child: Text('No data Available'));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final catergoryData = newCategoryData[index];

                  return ShowCategory(
                    image: catergoryData.urlToImage ?? '',
                    title: catergoryData.title ?? '',
                    desc: catergoryData.description ?? '',
                    url: catergoryData.url ?? '',
                  );
                },
                itemCount: newCategoryData.length,
              );
            },
          ),
        ),
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String image, desc, title, url;

  ShowCategory({
    required this.image,
    required this.desc,
    required this.title,
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchInWebView(Uri.parse(url));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image.isNotEmpty
                    ? image
                    : 'https://www.pngmart.com/files/11/WWW-PNG-Image.png',
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              desc,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchInWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
}
