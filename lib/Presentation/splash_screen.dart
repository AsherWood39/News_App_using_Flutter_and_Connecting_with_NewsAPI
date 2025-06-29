import 'package:flutter/material.dart';
import 'package:news_app_using_newsapi_key/Presentation/landing_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 6), () {
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LandingPage()),
          );
        }
      });
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            'assets/original-0c6f9674172354fc7fb7ff1915cd2afc.gif',
            scale: 4.0,
          ),
        ),
      ),
    );
  }
}
