import 'dart:ffi';

import 'package:crypto_portfolio/db/crypto_database.dart';
import 'package:crypto_portfolio/db/screens/admin_page.dart';
import 'package:crypto_portfolio/db/screens/coin_details_page.dart';
import 'package:crypto_portfolio/db/screens/home_page.dart';
import 'package:crypto_portfolio/db/screens/signup_page.dart';
import 'package:crypto_portfolio/main.dart';
import 'package:crypto_portfolio/modal/coins.dart';
import 'package:crypto_portfolio/modal/user_item_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

late String mobileInput;
late String passwordInput;
final _formKey = GlobalKey<FormState>();
final List<String> mobileNoList = [];
late List<UserItemModel> credentials;
late String password;

class LoginPage extends StatefulWidget {
  static const routeName = '/login-screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserCredentials();
  }

  void loadUserCredentials() async {
    credentials = await CryptoDatabase.instance.readUserCredentials();
    setState(() {
      credentials;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.appName),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 150.0,
                width: 190.0,
                padding: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(
                  child: Image.asset('assets/icon.png'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a mobile number';
                    }

                    if (value.length != 10) {
                      return 'Please enter a 10 digit number';
                    }
                  },
                  onSaved: (value) => mobileInput = value!,
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile Number',
                      hintText: 'Enter valid 10 digit mobile number'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter a password';
                  },
                  onSaved: (value) => passwordInput = value!,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your secure password'),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (mobileInput == MyApp.adminCredential) {
                        if (passwordInput == MyApp.adminCredential) {
                          final scaffold = ScaffoldMessenger.of(context);
                          scaffold.showSnackBar(
                            SnackBar(
                              content: const Text('Welcome to admin page.'),
                              action: SnackBarAction(
                                  label: 'OK',
                                  onPressed: scaffold.hideCurrentSnackBar),
                            ),
                          );
                          Navigator.of(context).pushNamed(AdminPage.routeName);
                        }
                      }
                      password = await CryptoDatabase.instance
                          .readPassword(mobileInput);
                      if (password == passwordInput) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                                userID: credentials
                                    .firstWhere((element) =>
                                        element.userMobile == mobileInput)
                                    .userID),
                          ),
                        );
                        
                        
                       
                      } else {
                        final scaffold = ScaffoldMessenger.of(context);
                        scaffold.showSnackBar(
                          SnackBar(
                            content: const Text('Wrong Password'),
                            action: SnackBarAction(
                                label: 'OK',
                                onPressed: scaffold.hideCurrentSnackBar),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SignUpPage.routeName);
                },
                child: Text(
                  'New User? Sign Up',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// onPressed: () async {
//               coins coin =
//                   coins(coinID: 1, coinName: coinName, coinPrice: coinPrice);
//               CryptoDatabase.instance.insert_into_coins(coin);