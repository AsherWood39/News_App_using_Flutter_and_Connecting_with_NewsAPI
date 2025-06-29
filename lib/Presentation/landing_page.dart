import 'package:flutter/material.dart';
import 'package:news_app_using_newsapi_key/Infrastructure/db_functions.dart';
import 'package:news_app_using_newsapi_key/Presentation/login_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              FutureBuilder(
                future: fetchBingImageUrl(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.7,
                    );
                  } else if (asyncSnapshot.hasError || !asyncSnapshot.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.7,
                      child: Center(child: Text('Image failed to load')),
                    );
                  }

                  return Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      child: Image.network(
                        asyncSnapshot.data!,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.6,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 18.0),
              Text(
                'News from around the',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                ),
              ),
              Text(
                'world for You',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Best time to read, take your time to read',
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
              Text(
                'a little more of this world',
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                padding: WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(vertical: 16.0),
                ),
                elevation: WidgetStatePropertyAll(4.0),
                shadowColor: WidgetStatePropertyAll<Color>(Colors.black),
              ),
              child: Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
