
import 'package:flutter_defualt_project/data/models/news_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/default_model.dart';

class LocalDatabase{
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase(){
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async{
    if(_database !=null){
      return _database!;
    }else{
      _database = await _initDB("defaultDatabase.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName)async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,dbName);
    return await openDatabase(path,version: 1,onCreate: _createDB);
  }

  Future _createDB(Database db, int version)async{
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute('''
    CREATE TABLE ${NewsModelFields.newsTable}(
    ${NewsModelFields.id} $idType,
    ${NewsModelFields.newsTitle} $textType,
    ${NewsModelFields.newsBody} $textType,
    ${NewsModelFields.newsDataTitle} $textType,
    ${NewsModelFields.newsDataBody} $textType,
    ${NewsModelFields.newsDataImg} $textType,
    ${NewsModelFields.newsDataDatetime} $textType
    );
    ''');
    // await db.execute('''
    // CREATE TABLE ${ProductModelFields.favorites} (
    // ${ProductModelFields.id} $idType,
    // ${ProductModelFields.productId} $intType,
    // ${ProductModelFields.price} $intType,
    // ${ProductModelFields.count} $intType,
    // ${ProductModelFields.name} $textType,
    // ${ProductModelFields.imageUrl} $textType
    // );
    // ''');
  }
//-------------------------------NEWS SERVICE------------------------------------------
  static Future<NewsModel> insertNews(NewsModel newsModel) async {
    final db = await getInstance.database;
    final int id = await db.insert(
        NewsModelFields.newsTable, newsModel.toJson());
    return newsModel.copyWith(id: id);
  }

  static Future<List<NewsModel>> getAllNews() async {
    List<NewsModel> allNews = [];
    final db = await getInstance.database;
    allNews = (await db.query(NewsModelFields.newsTable))
        .map((e) => NewsModel.fromJson(e))
        .toList();

    return allNews;
  }

  static deleteNew(int id) async {
    final db = await getInstance.database;
    db.delete(
      NewsModelFields.newsTable,
      where: "${NewsModelFields.id} = ?",
      whereArgs: [id],
    );
  }

  static deleteAllNews() async {
    final db = await getInstance.database;
    db.delete(
      NewsModelFields.newsTable,
    );
  }


//-------------------------------CONTACT SERVICE------------------------------------------
  static Future<List<DefaultModel>> getContactsByAlphabet(
      String order) async {
    List<DefaultModel> allToDos = [];
    final db = await getInstance.database;
    allToDos = (await db.query(DefaultModelFields.defaultTable,
        orderBy: "${DefaultModelFields.name} $order"))
        .map((e) => DefaultModel.fromJson(e))
        .toList();
    return allToDos;
  }

  static updateContactName({required int id, required String name}) async {
    final db = await getInstance.database;
    db.update(
      DefaultModelFields.defaultTable,
      {DefaultModelFields.name: name},
      where: "${DefaultModelFields.id} = ?",
      whereArgs: [id],
    );
  }

  static updateInfo({required DefaultModel defaultModel}) async {
    final db = await getInstance.database;
    db.update(
      DefaultModelFields.defaultTable,
      defaultModel.toJson(),
      where: "${DefaultModelFields.id} = ?",
      whereArgs: [defaultModel.id],
    );
  }



  static Future<List<DefaultModel>> getInfoByLimit(int limit) async {
    List<DefaultModel> allToDos = [];
    final db = await getInstance.database;
    allToDos = (await db.query(DefaultModelFields.defaultTable,
        limit: limit, orderBy: "${DefaultModelFields.name} ASC"))
        .map((e) => DefaultModel.fromJson(e))
        .toList();

    return allToDos;
  }

  static Future<DefaultModel?> getSingleContact(int id) async {
    List<DefaultModel> allInfo = [];
    final db = await getInstance.database;
    allInfo = (await db.query(
      DefaultModelFields.defaultTable,
      where: "${DefaultModelFields.id} = ?",
      whereArgs: [id],
    ))
        .map((e) => DefaultModel.fromJson(e))
        .toList();

    if (allInfo.isNotEmpty) {
      return allInfo.first;
    }
    return allInfo.last;
  }

  static Future<List<DefaultModel>> getInfoByQuery(String query) async {
    List<DefaultModel> allInfo = [];
    final db = await getInstance.database;
    allInfo = (await db.query(
      DefaultModelFields.defaultTable,
      where: "${DefaultModelFields.name} LIKE ?",
      whereArgs: [query],
    ))
        .map((e) => DefaultModel.fromJson(e))
        .toList();
    return allInfo;
  }
}