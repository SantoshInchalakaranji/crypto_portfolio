import 'package:crypto_portfolio/db/screens/admin_page.dart';
import 'package:crypto_portfolio/db/screens/coin_details_page.dart';
import 'package:crypto_portfolio/db/screens/home_page.dart';
import 'package:crypto_portfolio/db/screens/login_page.dart';
import 'package:crypto_portfolio/db/screens/signup_page.dart';
import 'package:crypto_portfolio/db/screens/user_details_page.dart';
import 'package:crypto_portfolio/widgets/user_coin_item.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static String adminCredential = '0000000000';
  static String appName = 'CRYPTOFOLIO';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
          
          
         
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1:const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 50, 50, 50),
                   fontWeight: FontWeight.w700,
                  
                ),
                
                headline1:const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                 
                ),
                headline2:const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 60, 60, 60),
                  fontWeight: FontWeight.bold,
                 
                ),
              )),
      home: LoginPage(),
      //initialRoute: SignUpPage.routeName,
      routes: {
        LoginPage.routeName: (ctx) => LoginPage(),
        SignUpPage.routeName: (ctx) => SignUpPage(),
        AdminPage.routeName: (ctx) => AdminPage(),
        UserDetailsPage.routeName: (ctx)=> UserDetailsPage(),
        CoinDetailsPage.routeName: (ctx)  => CoinDetailsPage(),
       
      },
    );
  }
}
