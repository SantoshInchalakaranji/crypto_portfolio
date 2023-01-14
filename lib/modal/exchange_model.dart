final String tableExchange = 'exchange';

class ExchangeFields {
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
}
