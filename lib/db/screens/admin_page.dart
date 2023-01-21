import 'package:crypto_portfolio/db/screens/coin_details_page.dart';
import 'package:crypto_portfolio/db/screens/user_details_page.dart';
import 'package:crypto_portfolio/main.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  static const routeName = '/admin-screen';
  const AdminPage({ Key? key }) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(MyApp.appName),),
      body:GridView(
        padding: const EdgeInsets.all(16),
        children:[
        InkWell(
      onTap: () {
         Navigator.of(context).pushNamed(UserDetailsPage.routeName
                 );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Text(
          "User Details",
          style: Theme.of(context).textTheme.headline1,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.withOpacity(.7), Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16)),
      ),
    ),
    InkWell(
      onTap: () {
         Navigator.of(context).pushNamed(CoinDetailsPage.routeName
                 );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Text(
          "Coin Details",
          style: Theme.of(context).textTheme.headline1,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.withOpacity(.7), Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16)),
      ),
    ),

      ],
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
 
    )
    );
  }
}