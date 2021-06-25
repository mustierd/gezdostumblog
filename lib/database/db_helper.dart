import 'dart:async';

import 'package:gezdostumblog/models/equipment_post_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "ekipman2.db");
    var ekipmanDb = await openDatabase(dbPath, onCreate: createDb, version: 1);
    return ekipmanDb;
  }

  FutureOr<void> createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE ekipmanTablo(id INTEGER PRIMARY KEY,product TEXT,userName TEXT,title TEXT,body TEXT,email TEXT,image TEXT)");
  }

  Future<List<EquipmentPostModel>> getProducts() async {
    Database db = await this.db;

    var result = await db.query("ekipmanTablo", orderBy: "id DESC");
    return List.generate(result.length, (index) {
      return EquipmentPostModel.fromObject(result[index]);
    });
  }

  Future<int> insert(EquipmentPostModel ekipmanModel) async {
    Database db = await this.db;
    var result = await db.insert("ekipmanTablo", ekipmanModel.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from ekipmanTablo where id=$id");
    return result;
  }

  Future<int> update(EquipmentPostModel ekipmanModel) async {
    Database db = await this.db;
    var result = await db.update("ekipmanTablo", ekipmanModel.toMap(),
        where: "id=?", whereArgs: [ekipmanModel.id]);
    return result;
  }
}

/*import 'dart:async';

import 'package:gezdostumblog/models/equipment_post_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database _db;

//db null ise, null olmayana kadar çalışacaktır.
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var dbFolder =
        await getDatabasesPath(); // database'in yazılabilir klasörün yolunu tutuyor.
    String path = join(dbFolder,
        "equipment.db"); // yol ile database i kaydetceğimiz dosyayı birleştiriyoruz.

    return await openDatabase(path,
        onCreate: _onCreate, version: 1); //database'i olusturur.
  }

  //Database olustugunda ilk çalışacak metottur.(onCreate)
  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE EquipmentTable(id INTEGER PRIMARY KEY,title TEXT,body TEXT,image TEXT)");
  }

  Future<List<EquipmentPostModel>> getEquipment() async {
    var dbClient =
        await db; // dbClient ile artık db den veri çekme işlemlerini yapıyoruz.

    var result = await dbClient.query("EquipmentTable", orderBy: "id");
    //map halinden. liste haline uygun dönüştürerek döndürüyoruz.
    return result.map((data) => EquipmentPostModel.fromMap(data)).toList();
  }

  Future<int> insertEquipment(EquipmentPostModel equipmentModel) async {
    var dbClient = await db;
    return await dbClient.insert("EquipmentTable", equipmentModel.toMap());
  }

  Future<int> updateContact(EquipmentPostModel equipmentModel) async {
    var dbClient = await db;
    return await dbClient.update("EquipmentTable", equipmentModel.toMap(),
        where: "id=?", whereArgs: [equipmentModel.id]);
  }

  Future<void> removeContact(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete("EquipmentTable", where: "id=?", whereArgs: [id]);
  }
}*/
