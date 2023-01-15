import 'dart:ffi';

import 'package:crypto_portfolio/db/crypto_database.dart';
import 'package:crypto_portfolio/modal/coins.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

late String mobileInput;
late String passwordInput;
late String nameInput;
late String emailInput;

class SignUpPage extends StatefulWidget {
  static const routeName = '/signup-screen';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRYPTOFOLIO"),
      ),
      body: SingleChildScrollView(
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
              child: TextField(
                onChanged: (value) {
                  nameInput = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter User Name'),
              ),
            ),
             
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                  mobileInput = value;
                },
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile Number',
                    hintText: 'Enter valid 10 digit mobile number'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                  emailInput = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid E-mail address'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                  passwordInput = value;
                },
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
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //  context, MaterialPageRoute(builder: (_) => HomePage()));
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
             
            ),
             SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}



// onPressed: () async {
//               coins coin =
//                   coins(coinID: 1, coinName: coinName, coinPrice: coinPrice);
//               CryptoDatabase.instance.insert_into_coins(coin);