import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ListItem {
  final int coinID;
  final String coinName;
  final double coinPrice;
  final double totalCoin;
  final double totalAmt;

  ListItem(
      {required this.coinID,
      required this.coinName,
      required this.coinPrice,
      required this.totalCoin,
      required this.totalAmt
      });
}
