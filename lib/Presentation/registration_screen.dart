// ignore_for_file: unnecessary_import

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_app_using_newsapi_key/Infrastructure/db_functions.dart';
import 'package:news_app_using_newsapi_key/Model/news_list_model/user_model.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                  image: AssetImage(
                    'assets/high-angle-geometrical-figures-with-copy-space.jpg',
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
                child: Form(
                  key: _registerFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.red.shade200,
                            fontWeight: FontWeight.bold,
                            fontSize: 45.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: nameController,
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                            ? 'Name is Required'
                            : null,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red.shade50,
                              width: 2.0,
                            ),
                          ),
                          hintText: 'Name',
                          hintStyle: TextStyle(color: Colors.red.shade50),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                            ? 'Email is Required'
                            : null,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red.shade50,
                              width: 2.0,
                            ),
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.red.shade50),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                            ? 'Password is Required'
                            : null,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red.shade50,
                              width: 2.0,
                            ),
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.red.shade50),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.red.shade100,
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (_registerFormKey.currentState!.validate()) {
                                bool success = await addUser(
                                  UserModel(
                                    '',
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                );

                                final snackBar = SnackBar(
                                  content: Text(
                                    success == true
                                        ? 'Successfully Registered'
                                        : 'Error: Error in registering the User',
                                  ),
                                  action: SnackBarAction(
                                    label: 'ok',
                                    onPressed: () {},
                                  ),
                                );

                                if (!context.mounted) return;

                                if (success == true) {
                                  Navigator.of(context).pop();
                                }

                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(snackBar);
                              }
                            },
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: Colors.red.shade100,
                              size: 50.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Already have an Account?',
                            style: TextStyle(color: Colors.red.shade50),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.red.shade100,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.red.shade100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
