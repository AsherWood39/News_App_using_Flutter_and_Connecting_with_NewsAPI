import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_using_newsapi_key/API/api.dart';
import 'package:news_app_using_newsapi_key/Core/core.dart';
import 'package:news_app_using_newsapi_key/Model/bing_image_model/bing_image_model.dart';
import 'package:news_app_using_newsapi_key/Model/news_list_model/user_model.dart';

Future<void> getAllNewsInNotifier(String? categoryName) async {
  final newsData = await getAllNews();
  newsNotifier.value = newsData.articles ?? [];

  final sliderData = await getAllNewsForSlider();
  sliderNotifier.value = sliderData.articles ?? [];

  final categoryData = await getAllNewsForCategory(categoryName!);
  categoryNewsNotifier.value = categoryData.articles ?? [];
}

Future<String> fetchBingImageUrl() async {
  final proxyUrl = 'https://api.allorigins.win/raw?url=';
  final bingUrl =
      'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=8&mkt=en-US';

  final encodedBingUrl = Uri.encodeComponent(bingUrl);

  final response = await http.get(Uri.parse('$proxyUrl$encodedBingUrl'));

  if (response.statusCode != 200) {
    throw Exception('Failed to load Bing image data');
  }

  final result = jsonDecode(response.body) as Map<String, dynamic>;
  final bingImageModel = BingImageModel.fromJson(result);

  final imageList = bingImageModel.images ?? [];

  if (imageList.isEmpty) {
    throw Exception('No images found.');
  }

  final randomIndex = Random().nextInt(imageList.length);
  return 'https://www.bing.com${imageList[randomIndex].url}';
}

Future<bool> addUser(UserModel u) async {
  try {
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: u.userEmail,
          password: u.userPassword,
        );

    // ignore: unnecessary_null_comparison
    if (userCredential != null) {
      await FirebaseFirestore.instance
          .collection('news_users')
          .doc(userCredential.user!.uid)
          .set({'user_name': u.userName, 'user_email': u.userEmail});
      return Future.value(true);
    }
    return Future.value(false);
  } catch (e) {
    return Future.value(false);
  }
}

Future<bool> checkLogin(UserModel u) async {
  try {
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: u.userEmail,
          password: u.userPassword,
        );
    // ignore: unnecessary_null_comparison
    if (userCredential != null) {
      currentUserId = userCredential.user!.uid;
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  } catch (e) {
    return Future.value(false);
  }
}

Future<UserModel> loadUser(String userId) async {
  final firebaseInstance = await FirebaseFirestore.instance
      .collection('news_users')
      .doc(userId)
      .get();
  final userData = firebaseInstance.data();

  UserModel u = UserModel(
    userId,
    userData!['user_name'],
    userData['user_email'],
    '',
  );

  return Future.value(u);
}
