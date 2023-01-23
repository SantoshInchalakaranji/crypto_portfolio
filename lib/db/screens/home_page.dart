import 'dart:math';

import 'package:crypto_portfolio/db/crypto_database.dart';
import 'package:crypto_portfolio/modal/coins.dart';
import 'package:crypto_portfolio/modal/exchange_model.dart';
import 'package:crypto_portfolio/widgets/add_ex_coin.dart';
import 'package:crypto_portfolio/widgets/dialog.dart';
import 'package:crypto_portfolio/widgets/user_coin_item.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  final int userID;
  const HomePage({Key? key, required this.userID}) : super(key: key);

  static const routeName = '/home-screen';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Exchange> ExCoinList = [];
  List<coins> coinList = [];
  late String _chosenValue;
  String _selectedValue = 'Option 2';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readDatabase();
  }

  void readDatabase() async {
    ExCoinList = await CryptoDatabase.instance.readExCoins(widget.userID);
    coinList = await CryptoDatabase.instance.readAllCoins();
    setState(() {
      ExCoinList;
      coinList;
      _chosenValue = coinList.first.coinName;
    });
  }

  void updateExCoin(Exchange exCoin) {
    int index = ExCoinList.indexWhere((element) =>
        element.coinID == exCoin.coinID && element.userID == widget.userID);
    ExCoinList[index] = exCoin;
    CryptoDatabase.instance.updateExCoin(exCoin);
    setState(() {
      ExCoinList;
    });
  }

  void addExCoin(Exchange exCoin) {
    if (ExCoinList.map((coin) => coin.coinID)
        .toList()
        .contains(exCoin.coinID)) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Coin already added. Select a different coin.'),
          action: SnackBarAction(
              label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
        ),
      );
    } else {
      CryptoDatabase.instance.insert_into_exchange(exCoin);
      ExCoinList.add(exCoin);
      setState(() {
        ExCoinList;
      });
    }
  }

  void deleteExCoin(int userID, int coinID) {
    CryptoDatabase.instance.deleteExCoin(coinID, userID);
    setState(() {
      ExCoinList.removeWhere(
          (element) => element.coinID == coinID && element.userID == userID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    final appBar = AppBar(title: Text("CRYPTOFOLIO"));
    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        height: (mQuery.size.height -
                appBar.preferredSize.height -
                mQuery.padding.top) *
            1,
        child: Container(
          child: ExCoinList.isEmpty
              ? LayoutBuilder(builder: (ctx, constrains) {
                  return Container(
                      height: constrains.maxHeight * .60,
                      child: Image.asset(
                        'assets/empty.png',
                        fit: BoxFit.cover,
                      ));
                })
              : ListView(
                  children: ExCoinList.map((EXcoin) => UserCoinItem(
                        exItem: EXcoin,
                        updateExCoin: updateExCoin,
                        deleteExCoin: deleteExCoin,
                      )).toList(),
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(
        builder: (cont) => FloatingActionButton(
          onPressed: () {
            showDialog(
                context: cont,
                builder: (BuildContext context) {
                  return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DialogDemo(
                        userID: widget.userID,
                        coinList: coinList,
                        addExCoin: addExCoin,
                      ));
                });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
