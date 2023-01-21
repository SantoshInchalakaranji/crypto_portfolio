import 'dart:math';

import 'package:crypto_portfolio/modal/coins.dart';
import 'package:flutter/material.dart';

class CoinItem extends StatefulWidget {
  final coins coinModelItem;
  final Function deleteCoin;
  final Function editCoin;
  const CoinItem(
      {Key? key, required this.coinModelItem, required this.deleteCoin, required this.editCoin})
      : super(key: key);
  @override
  State<CoinItem> createState() => _CoinItemState();
}

class _CoinItemState extends State<CoinItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
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
            widget.coinModelItem.coinName,
            style: Theme.of(context).textTheme.headline1,
          ),
          subtitle: Text('Price:\$' + widget.coinModelItem.coinPrice.toString()
              //style: Theme.of(context).textTheme.bodyText2,
              ),
          trailing:  Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => widget.editCoin(widget.coinModelItem.coinID),
                icon: const Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                onPressed: () => widget.deleteCoin(widget.coinModelItem.coinID),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ) // MediaQuery.of(context).size.width > 600
          //     ? TextButton.icon(
          //         onPressed: () => widget.deleteTx(widget.transaction.id),
          //         icon: const Icon(Icons.delete),
          //         style: TextButton.styleFrom(
          //             primary: Theme.of(context).primaryColor),
          //         label: const Text(
          //           'Delete',
          //         ))
          //:

          ),
    );
  }
}
