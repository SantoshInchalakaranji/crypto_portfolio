import 'package:crypto_portfolio/db/screens/login_page.dart';
import 'package:crypto_portfolio/db/screens/signup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home:  LoginPage(),
      routes: {
        LoginPage.routeName : (ctx) => LoginPage(),
        SignUpPage.routeName: (ctx) => SignUpPage()
      },
    );
  }
}


