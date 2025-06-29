// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app_using_newsapi_key/Core/core.dart';
import 'package:news_app_using_newsapi_key/Infrastructure/db_functions.dart';
import 'package:news_app_using_newsapi_key/Model/news_list_model/article.dart';
import 'package:news_app_using_newsapi_key/Model/news_list_model/user_model.dart';
import 'package:news_app_using_newsapi_key/Presentation/category_news.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  UserModel user;

  HomeScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    getAllNewsInNotifier('');
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
          child: ListView(
            children: [
              SizedBox(
                height: 70,
                child: ValueListenableBuilder(
                  valueListenable: categoryNotifier,
                  builder: (context, newCategory, _) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final categoryData = newCategory[index];

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
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Breaking News!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BreakingNews()),
                      );
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ValueListenableBuilder<List<Article>>(
                valueListenable: sliderNotifier,
                builder: (context, newSlider, _) {
                  if (newSlider.isEmpty) {
                    return Center(child: Text('No data Available'));
                  }

                  return CarouselSlider.builder(
                    itemCount: newSlider.length,
                    itemBuilder: (context, index, realIndex) {
                      final sliderData = newSlider[index];

                      return buildImage(
                        context,
                        sliderData.urlToImage ?? '',
                        index,
                        sliderData.title ?? '',
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        Provider.of<CarouselIndexProvider>(
                          context,
                          listen: false,
                        ).setIndex(index);
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0),
              Center(child: buildIndicator(context)),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending News!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TrendingNews()),
                      );
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              ValueListenableBuilder(
                valueListenable: newsNotifier,
                builder: (context, newNews, _) {
                  if (newNews.isEmpty) {
                    return const Center(child: Text("No news available"));
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final newsData = newNews[index];

                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: .2),
                        child: ListTile(
                          onTap: () {
                            if (newsData.url != null &&
                                newsData.url!.isNotEmpty) {
                              _launchInWebView(Uri.parse(newsData.url!));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('No URL available')),
                              );
                            }
                          },
                          leading: SizedBox(
                            height: 200,
                            width: 76,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                fit: BoxFit.cover,
                                newsData.urlToImage?.isNotEmpty == true
                                    ? newsData.urlToImage!
                                    : 'https://www.pngmart.com/files/11/WWW-PNG-Image.png',
                              ),
                            ),
                          ),
                          title: Text(
                            newsData.title ?? '',
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            children: [
                              Text(
                                '${newsData.author}, ${newsData.publishedAt}',
                              ),
                              Text(
                                _truncateText(newsData.description ?? '', 50),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.transparent),
                    itemCount: newNews.length,
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
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: 200.0,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildIndicator(BuildContext context) {
    final provider = Provider.of<CarouselIndexProvider?>(context, listen: true);
    final activeIndex = provider?.index ?? 0;

    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: sliderNotifier.value.length,
      effect: ScrollingDotsEffect(),
    );
  }

  String _truncateText(String text, int maxChars) {
    if (text.length <= maxChars) return text;
    return text.substring(0, maxChars);
  }
}

Future<void> _launchInWebView(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
    throw Exception('Could not launch $url');
  }
}

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  const CategoryTile({super.key, this.image, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CategoryNews(categoryName: categoryName),
        ),
      ),
      child: Container(
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
      ),
    );
  }
}

class CarouselIndexProvider extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  void setIndex(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }
}

class BreakingNews extends StatelessWidget {
  BreakingNews({super.key});

  @override
  Widget build(BuildContext context) {
    getAllNewsInNotifier('');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Breaking'),
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
            valueListenable: sliderNotifier,
            builder: (context, newSliderData, child) {
              if (newSliderData.isEmpty) {
                return Center(child: Text('No data Available'));
              }

              return ValueListenableBuilder(
                valueListenable: sliderNotifier,
                builder: (context, newSlider, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final sliderData = newSlider[index];

                      return GestureDetector(
                        onTap: () =>
                            _launchInWebView(Uri.parse(sliderData.url ?? '')),
                        child: Container(
                          margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  sliderData.urlToImage ??
                                      'https://www.pngmart.com/files/11/WWW-PNG-Image.png',
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                sliderData.title ?? '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                sliderData.description ?? '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: newSliderData.length,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class TrendingNews extends StatelessWidget {
  TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    getAllNewsInNotifier('');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Trending'),
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
            valueListenable: newsNotifier,
            builder: (context, newNews, child) {
              if (newNews.isEmpty) {
                return Center(child: Text('No data Available'));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: newNews.length,
                itemBuilder: (context, index) {
                  final newsData = newNews[index];

                  return GestureDetector(
                    onTap: () =>
                        _launchInWebView(Uri.parse(newsData.url ?? '')),
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              newsData.urlToImage ??
                                  'https://www.pngmart.com/files/11/WWW-PNG-Image.png',
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            newsData.title ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            newsData.description ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
