import 'package:crypto_portfolio/modal/coins.dart';
import 'package:crypto_portfolio/modal/exchange_model.dart';
import 'package:crypto_portfolio/modal/user_item_model.dart';
import 'package:crypto_portfolio/modal/user_model.dart';
import 'package:crypto_portfolio/widgets/user_item.dart';
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

 

    // used batch instead of db.execute because batch is more efficient for creating multiple tables
    // but we have to add extra line batch.commit() at the end
    await db.execute('''
CREATE TABLE $tableCoins (
  ${coinFields.coinID} $idType,
  ${coinFields.coinName} $varchar,
  ${coinFields.coinPrice} $DOUBLE
)
''');
    await db.execute('''
CREATE TABLE $tableExchange (
   ${ExchangeFields.coinID} INTEGER,
  ${ExchangeFields.userID} INTEGER,
  ${ExchangeFields.Binance} $DOUBLE,
 ${ExchangeFields.FTX} $DOUBLE,
 ${ExchangeFields.OctaFX} $DOUBLE,
 ${ExchangeFields.BinaceBuyPrice} $DOUBLE,
 ${ExchangeFields.FTXBuyPrice} $DOUBLE,
  ${ExchangeFields.OctaFXBuyPrice} $DOUBLE,
  PRIMARY KEY(${ExchangeFields.coinID},${ExchangeFields.userID}),
  FOREIGN KEY(${ExchangeFields.userID}) REFERENCES $tableUsers(${UserFields.userID}) ON DELETE CASCADE,
  FOREIGN KEY(${ExchangeFields.coinID}) REFERENCES $tableCoins(${coinFields.coinID}) ON DELETE CASCADE

)
''');
    await db.execute('''
CREATE TABLE $tableUsers (
   ${UserFields.userID} INTEGER,
  ${UserFields.mobile} TEXT,
 ${UserFields.password} $varchar,
 ${UserFields.eMail} $varchar,
 ${UserFields.userName} $varchar,
 PRIMARY KEY(${UserFields.userID})
 
)
''');

    
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

  // to read a single coin object, 1 row ,
  Future<coins> readCoin(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableCoins,
        //we can pass get necessary column names which is to be retrived, here i am retriving all colums
        columns: coinFields.values,
        where: '${coinFields.coinID}=$id');
    if (maps.isNotEmpty) {
      return coins.fromJson(maps.first);
    } else {
      throw Exception('coinID $id not found');
    }
  }

  Future<List<coins>> readAllCoins() async {
    final db = await instance.database;
    final result = await db.query(tableCoins,
        orderBy:
            '${coinFields.coinName} ASC'); //ordering the coins in ascsending order A-Z
    return result.map((json) => coins.fromJson(json)).toList();
  }

  Future<List<UserItemModel>> readUserCredentials() async {
    final db = await instance.database;
    final result = await db.rawQuery(
        'SELECT ${UserFields.userID}, ${UserFields.mobile},${UserFields.userName} from ${tableUsers}');
    return result.map((json) => UserItemModel.fromJson(json)).toList();
  }

  Future<List<String>> getMobileNumbers() async {
    final db = await instance.database;

    final result =
        await db.rawQuery('SELECT ${UserFields.mobile} from ${tableUsers}');
    return result
        .map((numbers) => numbers[UserFields.mobile] as String)
        .toList();
  }

  Future<int> updateCoin(coins coin) async {
    final db = await instance.database;
    return db.update(tableCoins, coin.toJson(),
        where: '${coinFields.coinID}= ${coin.coinID}');
  }

  Future<int> deleteCoin(int id) async {
    final db = await instance.database;
    return await db.delete(tableCoins, where: '${coinFields.coinID}= $id');
  }
}
