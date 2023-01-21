import 'package:crypto_portfolio/db/crypto_database.dart';
import 'package:crypto_portfolio/modal/user_item_model.dart';
import 'package:crypto_portfolio/widgets/user_item.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);
  static const routeName = '/userDetails-screen';
  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  List<UserItemModel> userItemModelList = [
    // UserItemModel(userID: 0, userMobile: "8904901553", userName: "santosh")
  ];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    readDatabase();
  }
  @override
  Widget build(BuildContext context) {
    

    final mQuery = MediaQuery.of(context);
    final appBar = AppBar(title: Text('USER DETAILS'));

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        height: (mQuery.size.height -
                appBar.preferredSize.height -
                mQuery.padding.top) *
            1,
        child: Container(
          child: userItemModelList.isEmpty
              ? LayoutBuilder(builder: (ctx, constrains) {
                  return Container(
                      height: constrains.maxHeight * .60,
                      child: Image.asset(
                        'assets/empty.png',
                        fit: BoxFit.cover,
                      ));
                })
              : ListView(
                  children: userItemModelList
                      .map((ui) => UserItem(
                          userItemModel: ui,
                          key: ValueKey(ui.userID), //key is like findviewbyid
                          deleteUser: deleteUser))
                      .toList(),
                ),
        ),
      ),
    );
  }

  void deleteUser(int id) {
    setState(
      () {
        userItemModelList.removeWhere(
          (element) {
            return element.userID == id;
          },
        );
      },
    );
  }

  void readDatabase() async {
    userItemModelList = await CryptoDatabase.instance.readUserCredentials();
    setState(() {
      userItemModelList;
    });
  }
}
