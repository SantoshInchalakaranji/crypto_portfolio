import 'dart:ffi';

import 'package:crypto_portfolio/db/crypto_database.dart';
import 'package:crypto_portfolio/db/screens/home_page.dart';
import 'package:crypto_portfolio/db/screens/login_page.dart';
import 'package:crypto_portfolio/db/screens/user_details_page.dart';
import 'package:crypto_portfolio/main.dart';
import 'package:crypto_portfolio/modal/coins.dart';
import 'package:crypto_portfolio/modal/user_item_model.dart';
import 'package:crypto_portfolio/modal/user_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';

String mobileInput = '';
String passwordInput = '';
String nameInput = '';
String emailInput = '';
List<String> _mobileNumberList = [];
late int generatedID;
late List<UserItemModel> credentials;

final _formKey = GlobalKey<FormState>();

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
                        return 'Please Enter Name';
                      }
                    },
                    onSaved: (value) => nameInput = value!,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter User Name'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a mobile number';
                      }
                      if (value == MyApp.adminCredential) {
                        if(passwordInput == MyApp.adminCredential){
       Navigator.of(context).pushNamed(LoginPage.routeName
                 );
    }
                      }
                      if (value.length != 10) {
                        return 'Please enter a 10 digit number';
                      }
                      loadMobileNumbersToValidate(value);
                      if (_mobileNumberList.contains(value)) {
                        final scaffold = ScaffoldMessenger.of(context);
                        scaffold.showSnackBar(
                          SnackBar(
                            content: const Text('Mobile number already taken'),
                            action: SnackBarAction(
                                label: 'OK',
                                onPressed: scaffold.hideCurrentSnackBar),
                          ),
                        );
                        return 'Mobile number already taken';
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
                        return 'Please enter an Email adress';
                    },
                    onSaved: (value) => emailInput = value!,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid E-mail address'),
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
                        if (_mobileNumberList.isEmpty) {
                          generatedID = 0;
                        } else {
                          generatedID =
                              credentials.last.userID as int;
                          generatedID++;
                        }
                        Users user = Users(
                            userID: generatedID,
                            mobile: mobileInput,
                            password: passwordInput,
                            eMail: emailInput,
                            userName: nameInput);

                        await CryptoDatabase.instance.insert_into_users(user);
                        print("generatedID=$generatedID");
                        // Fluttertoast.showToast(
                        //     msg: "success",
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.CENTER,
                        //     timeInSecForIosWeb: 1,
                        //     backgroundColor: Colors.red,
                        //     textColor: Colors.white,
                        //     fontSize: 16.0);
                        final scaffold = ScaffoldMessenger.of(context);
                        scaffold.showSnackBar(
                          SnackBar(
                            content: const Text(
                                'User account created successfully.'),
                            action: SnackBarAction(
                                label: 'OK',
                                onPressed: scaffold.hideCurrentSnackBar),
                          ),
                        );
                        Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  userID: generatedID) ,),
                  
            );
                      }

                       
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
        ));
  }

  Future loadMobileNumbersToValidate(String mobile) async {
    credentials = await CryptoDatabase.instance.readUserCredentials();
    _mobileNumberList = credentials
        .map((numbers) => numbers.userMobile as String)
        .toList();

    print(credentials);
  }
 
}





// onPressed: () async {
//               coins coin =
//                   coins(coinID: 1, coinName: coinName, coinPrice: coinPrice);
//               CryptoDatabase.instance.insert_into_coins(coin)