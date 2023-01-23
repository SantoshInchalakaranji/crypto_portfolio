final String tableExchange = 'exchange';

class ExchangeFields {

static final List<String> values = [
    coinID,userID,FTX,Binance, OctaFX, 
    BinaceBuyPrice, FTXBuyPrice, OctaFXBuyPrice
  ];

  static final String userID = 'userID';
  static final String coinID = 'coinID';
  static final String FTX = 'FTX';
  static final String Binance = 'Binance';
  static final String OctaFX = 'OctaFX';
  static final String BinaceBuyPrice = 'BinaceBuyPrice';
  static final String FTXBuyPrice = 'FTXBuyPrice';
  static final String OctaFXBuyPrice = 'OctaFXBuyPrice';
}

class Exchange {
   final int userID;
  final int coinID;
  final double FTX;
  final double Binance;
  final double OctaFX;
  final double BinaceBuyPrice;
  final double FTXBuyPrice;
  final double OctaFXBuyPrice;

  const Exchange(
      {required this.userID,
      required this.BinaceBuyPrice,
      required this.Binance,
      required this.FTX,
      required this.FTXBuyPrice,
      required this.OctaFX,
      required this.OctaFXBuyPrice,
      required this.coinID});

      Map<String, Object?> toJson() => {
        ExchangeFields.coinID: coinID,
        ExchangeFields.userID: userID,
       ExchangeFields.Binance: Binance,
        ExchangeFields.FTX: FTX,
        ExchangeFields.OctaFX: OctaFX,
        ExchangeFields.BinaceBuyPrice: BinaceBuyPrice,
        ExchangeFields.FTXBuyPrice: FTXBuyPrice,
        ExchangeFields.OctaFXBuyPrice: OctaFXBuyPrice
      };
       static Exchange fromJson(Map<String, Object?> json) => Exchange(
    coinID: json[ExchangeFields.coinID] as int,
    userID: json[ExchangeFields.userID] as int,
    Binance: json[ExchangeFields.Binance] as double,
    FTX: json[ExchangeFields.FTX] as double,
    OctaFX: json[ExchangeFields.OctaFX] as double,
    BinaceBuyPrice: json[ExchangeFields.BinaceBuyPrice] as double,
    FTXBuyPrice: json[ExchangeFields.FTXBuyPrice] as double,
    OctaFXBuyPrice: json[ExchangeFields.OctaFXBuyPrice] as double,
  );

  Exchange copy(
          {int? userID,
          int? coinID,
          double? FTX,
          double? Binance,
          double? OctaFX,
          double? BinaceBuyPrice,
          double? FTXBuyPrice,
          double? OctaFXBuyPrice}) =>
      Exchange(
          userID: userID ?? this.userID,
          BinaceBuyPrice: BinaceBuyPrice ?? this.BinaceBuyPrice,
          Binance: Binance ?? this.Binance,
          FTX: FTX ?? this.FTX,
          FTXBuyPrice: FTXBuyPrice ?? this.FTXBuyPrice,
          OctaFX: OctaFX ?? this.OctaFX,
          OctaFXBuyPrice: OctaFXBuyPrice ?? this.OctaFXBuyPrice,
          coinID: coinID ?? this.coinID);
}
