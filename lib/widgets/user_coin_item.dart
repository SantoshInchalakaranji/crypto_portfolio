import 'package:crypto_portfolio/db/crypto_database.dart';
import 'package:crypto_portfolio/modal/coins.dart';
import 'package:crypto_portfolio/modal/exchange_model.dart';
import 'package:crypto_portfolio/widgets/update_dialog.dart';
import 'package:flutter/material.dart';

class UserCoinItem extends StatefulWidget {
  final Exchange exItem;
  final Function updateExCoin;
  final Function deleteExCoin;

  UserCoinItem({
    required this.exItem,
    required this.updateExCoin,
    required this.deleteExCoin,
    Key? key,
  }) : super(key: key);

  @override
  State<UserCoinItem> createState() => _UserCoinItemState();
}

class _UserCoinItemState extends State<UserCoinItem> {
  late coins coin;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCoin();
  }

  void readCoin() async {
    coin = await CryptoDatabase.instance.readCoin(widget.exItem.coinID);
    setState(() {
      coin;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalCoins =
        widget.exItem.Binance + widget.exItem.FTX + widget.exItem.OctaFX;
    double totalAmtAtBuy =
        (widget.exItem.Binance * widget.exItem.BinaceBuyPrice) +
            (widget.exItem.FTX * widget.exItem.FTXBuyPrice) +
            (widget.exItem.OctaFX * widget.exItem.OctaFXBuyPrice);

    double totalAmtAtCurrent = totalCoins * coin.coinPrice;

    double gain = totalAmtAtCurrent - totalAmtAtBuy;

    List<coins> coinList = [coin];
    return InkWell(
      onLongPress: (){
     final scaffold = ScaffoldMessenger.of(context);
                        scaffold.showSnackBar(
                          SnackBar(
                            content: const Text(
                                'Delete coin?'),
                            action: SnackBarAction(
                                label: 'YES',
                                onPressed:()=> widget.deleteExCoin(widget.exItem.userID,
                                widget.exItem.coinID
                                )),
                          ),
                        );
                        
      },
      onTap:() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: UpdateDialog(coinList: coinList,
                      userID:  widget.exItem.userID,
                      updateExCoin: widget.updateExCoin,
                      previousCoin: widget.exItem,
                ));
                });
          },
      child: Wrap(
        children: [
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black54,
                      radius: 30,
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text('\$'),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      coin.coinName,
                      //  widget.coinModelItem.coinName,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Pirce:\$" + coin.coinPrice.toString(),
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    trailing: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "\$" + totalAmtAtCurrent.toString(),
                          // "\$"+widget.coinModelItem.coinPrice.toString(),
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          gain >= 0 ? "+${gain}" : "-${gain}",
                          style: gain >= 0
                              ? TextStyle(
                                  color: Color.fromARGB(255, 0, 255, 0),
                                )
                              : TextStyle(
                                  color: Color.fromARGB(255, 255, 0, 0),
                                ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Exchange",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Binance",
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "FTX",
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Octa FX",
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Total",
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Holdings",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(widget.exItem.Binance.toString()),
                        SizedBox(
                          height: 4,
                        ),
                        Text(widget.exItem.FTX.toString()),
                        SizedBox(
                          height: 4,
                        ),
                        Text(widget.exItem.OctaFX.toString()),
                        SizedBox(
                          height: 4,
                        ),
                        Text(totalCoins.toString()),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Bought At(\$)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(widget.exItem.BinaceBuyPrice.toString()),
                        SizedBox(
                          height: 4,
                        ),
                        Text(widget.exItem.FTXBuyPrice.toString()),
                        SizedBox(
                          height: 4,
                        ),
                        Text(widget.exItem.OctaFXBuyPrice.toString()),
                        SizedBox(
                          height: 4,
                        ),
                        Text(totalAmtAtBuy.toString()),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
