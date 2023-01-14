final String tableCoins = 'coins';

class coinFields {
  static final String coinID = 'coinID';
  static final String coinPrice = 'coinPrice';
  static final String coinName = 'coinName';
}

class coins {
  final int coinID;
  final double coinPrice;
  final String coinName;

  const coins(
      {required this.coinID, required this.coinName, required this.coinPrice});

  Map<String, Object?> toJson() => {
        coinFields.coinID: coinID,
        coinFields.coinName: coinName,
        coinFields.coinPrice: coinPrice
      };

  coins copy({
    int? coinID,
    double? coinPrice,
    String? coinName,
  }) =>
      coins(
          coinID: coinID ?? this.coinID,
          coinName: coinName ?? this.coinName,
          coinPrice: coinPrice ?? this.coinPrice);
}
