import 'package:crypto_portfolio/db/crypto_database.dart';
import 'package:crypto_portfolio/main.dart';
import 'package:crypto_portfolio/modal/coins.dart';
import 'package:crypto_portfolio/widgets/add_coin_bottom_window.dart';
import 'package:crypto_portfolio/widgets/coin_item.dart';
import 'package:crypto_portfolio/widgets/coin_updater.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:sqflite/sqflite.dart';

class CoinDetailsPage extends StatefulWidget {
  const CoinDetailsPage({Key? key}) : super(key: key);
  static const routeName = '/coinDetail-screen';
  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  List<coins> coinList = [];
  late int generatedCoinId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCoins();
  }

  Future loadCoins() async {
    coinList = await CryptoDatabase.instance.readAllCoins();
    setState(() {
      coinList;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    if (coinList.isEmpty) {
      generatedCoinId = 0;
    } else {
      generatedCoinId = coinList.map((coin) => coin.coinID).reduce(max);
      generatedCoinId++;
    }
    print("generated id =" + generatedCoinId.toString());


    void _addNewCoin(String coinName, double coinPrice) {
         
      try{
      final newCoin = coins(
          coinID: generatedCoinId, coinName: coinName, coinPrice: coinPrice);


      CryptoDatabase.instance.insert_into_coins(newCoin);
      print('inserted coin:' + newCoin.toString());
      setState(() {
        coinList.add(newCoin);
      });
      print(coinList);
      }
      on DatabaseException catch(e){
           final scaffold = ScaffoldMessenger.of(context);
                        scaffold.showSnackBar(
                          SnackBar(
                            content: const Text(
                                'Coin already exist'),
                            action: SnackBarAction(
                                label: 'OK',
                                onPressed: scaffold.hideCurrentSnackBar),
                          ),
                        );
                       
      }
    }

    void _startAddingCoin(BuildContext ctx) {
      showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: AddCoinBottomWindow(_addNewCoin),
          );
        },
      );
    }

    final mQuery = MediaQuery.of(context);
    final appBar = AppBar(title: Text("COIN DETAILS"));

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        height: (mQuery.size.height -
                appBar.preferredSize.height -
                mQuery.padding.top) *
            1,
        child: Container(
          child: coinList.isEmpty
              ? LayoutBuilder(builder: (ctx, constrains) {
                  return Container(
                      height: constrains.maxHeight * .60,
                      child: Image.asset(
                        'assets/empty.png',
                        fit: BoxFit.cover,
                      ));
                })
              : ListView(
                  children: coinList
                      .map((coin) => CoinItem(
                            coinModelItem: coin,
                            key: ValueKey(
                                coin.coinID), //key is like findviewbyid
                            deleteCoin: deleteCoin,
                            editCoin: editCoin,
                          ))
                      .toList(),
                ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(
        builder: (cont) => FloatingActionButton(
          onPressed: () => _startAddingCoin(cont),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void editCoin(int id) {
    coins coin = coinList.firstWhere((element) => element.coinID == id);

    showModalBottomSheet(
      context: this.context,
      builder: (_) {
        return GestureDetector(
          child: CoinUpdater(
            coin: coin,
            updaterFunction: updateCoin,
          ),
        );
      },
    );
  }

  void updateCoin(coins coin) {
    int index = coinList.indexWhere((element) => element.coinID == coin.coinID);
    coinList[index] = coin;
    CryptoDatabase.instance.updateCoin(coin);
    setState(() {
      coinList;
    });
  }

  void deleteCoin(int id) {
    CryptoDatabase.instance.deleteCoin(id);
    setState(
      () {
        coinList.removeWhere(
          (element) {
            return element.coinID == id;
          },
        );
      },
    );
    print(coinList);
  }
}
