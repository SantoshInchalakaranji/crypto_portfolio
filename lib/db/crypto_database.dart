import 'package:crypto_portfolio/modal/coins.dart';
import 'package:crypto_portfolio/modal/exchange_model.dart';
import 'package:crypto_portfolio/modal/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CryptoDatabase {
  static final CryptoDatabase instance = CryptoDatabase._init();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('crypto.db');
    return _database!;
  }

  CryptoDatabase._init();

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY';
    final varchar = 'TEXT NOT NULL';
    final integer = 'INTEGER NOT NULL';
    final DOUBLE = 'DOUBLE NOT NULL';
    final textPrimary = 'TEXT PRIMARY KEY';

    final batch = db.batch();
    batch.execute('''
CREATE TABLE $tableCoins (
  ${coinFields.coinID} $idType,
  ${coinFields.coinName} $varchar,
  ${coinFields.coinPrice} $DOUBLE
)
''');
    batch.execute('''
CREATE TABLE $tableExchange (
   ${ExchangeFields.coinID} $idType,
  ${ExchangeFields.userID} $idType,
  ${ExchangeFields.Binance} $DOUBLE,
 ${ExchangeFields.FTX} $DOUBLE,
 ${ExchangeFields.OctaFX} $DOUBLE,
 ${ExchangeFields.BinaceBuyPrice} $DOUBLE,
 ${ExchangeFields.FTXBuyPrice} $DOUBLE,
  ${ExchangeFields.OctaFXBuyPrice} $DOUBLE
)
''');
    batch.execute('''
CREATE TABLE $tableUsers (
   ${UserFields.userID} $idType,
  ${UserFields.mobile} $textPrimary,
 ${UserFields.password} $varchar,
 ${UserFields.eMail} $varchar,
 ${UserFields.userName} $varchar
 
)
''');

    await batch.commit();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<coins> insert_into_coins(coins coin) async {
    final db = await instance.database;
    final id = await db.insert(tableCoins, coin.toJson());
    return coin.copy();
  }
   Future<Exchange> insert_into_exchange(Exchange exchange) async {
    final db = await instance.database;
    final id = await db.insert(tableExchange, exchange.toJson());
    return exchange.copy();
  }
   Future<Users> insert_into_users(Users users) async {
    final db = await instance.database;
    final id = await db.insert(tableUsers, users.toJson());
    return users.copy();
  }
}
