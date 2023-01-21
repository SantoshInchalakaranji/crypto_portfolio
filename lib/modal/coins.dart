final String tableCoins = 'coins';

class coinFields {
  static final List<String> values = [coinID, coinName, coinPrice];

  static final String coinID = 'coinID';
  static final String coinPrice = 'coinPrice';
  static final String coinName = 'coinName';
}

class coins {
   final int coinID;
  late double coinPrice;
  late String coinName;

   coins(
      {required this.coinID, required this.coinName, required this.coinPrice});

  Map<String, Object?> toJson() => {
        coinFields.coinID: coinID,
        coinFields.coinName: coinName,
        coinFields.coinPrice: coinPrice
      };

  static coins fromJson(Map<String, Object?> json) => coins(
    coinID: json[coinFields.coinID] as int,
    coinName: json[coinFields.coinName] as String,
    coinPrice: json[coinFields.coinPrice] as double
  );

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
