import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_app_using_newsapi_key/Core/core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app_using_newsapi_key/Presentation/home_screen.dart';
import 'package:news_app_using_newsapi_key/Infrastructure/db_functions.dart';
import 'package:news_app_using_newsapi_key/Model/news_list_model/user_model.dart';
import 'package:news_app_using_newsapi_key/Presentation/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final proxyUrl = 'https://api.allorigins.win/raw?url=';
    final imageUrl =
        'https://img.freepik.com/free-photo/creative-abstract-pastel-background_23-2151954516.jpg?uid=R180870269&ga=GA1.1.1023686332.1750686394&w=740';
    final proxiedImageUrl = '$proxyUrl${Uri.encodeComponent(imageUrl)}';

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(proxiedImageUrl),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(
                color: Colors.black.withAlpha(50),
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 40.0,
                  ),
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '\tWelcome\n\tBack',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: emailController,
                          validator: (value) =>
                              (value == null || value.trim().isEmpty)
                              ? 'Email is Required'
                              : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(200),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Your Email',
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(
                              Icons.mail_rounded,
                              color: Colors.white,
                            ),
                            filled: true,
                            fillColor: Colors.white.withAlpha(84),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) =>
                              (value == null || value.trim().isEmpty)
                              ? 'Password is Required'
                              : null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(200),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.white.withAlpha(84),
                            prefixIcon: Icon(
                              Icons.password_rounded,
                              color: Colors.white,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(color: Colors.amber),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_loginFormKey.currentState!.validate()) {
                              final flag = await checkLogin(
                                UserModel(
                                  '',
                                  '',
                                  emailController.text,
                                  passwordController.text,
                                ),
                              );

                              if (!context.mounted) return;

                              if (flag == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Login Successful')),
                                );

                                final user = await loadUser(currentUserId!);

                                if (!context.mounted) return;

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(user: user),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Invalid User Credentials. Try again',
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.amber,
                            ),
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 12.0,
                              ),
                            ),
                            fixedSize: WidgetStateProperty.all(Size(150, 20)),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New User ?',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RegistrationScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'SignUp',
                                style: TextStyle(color: Colors.amber),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
