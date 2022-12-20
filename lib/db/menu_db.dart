import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/menu_model.dart';

class MenuDB {
  Future<Database> initDBMenu() async {
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "Menu2.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS Menu(
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          image TEXT NOT NULL,
          rating TEXT NOT NULL,
          price TEXT NOT NULL,
          tag TEXT NOT NULL,
          category TEXT NOT NULL,
          quantity TEXT NOT NULL,
          calories TEXT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertDataMenu(MenuModel menu) async {
    final Database db = await initDBMenu();
    db.insert("Menu", menu.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return true;
  }

  Future<List<MenuModel>> getDataMenu() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic>> data = await db.query("Menu");
    return data.map((e) => MenuModel.fromJson(e)).toList();
  }

  Future<List<MenuModel>> coffeedata() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic>> coffee =
        await db.rawQuery("SELECT * FROM Menu WHERE category=?", ['Coffee']);
    return coffee.map((e) => MenuModel.fromJson(e)).toList();
  }

  Future<List<MenuModel>> cakedata() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic>> cake =
        await db.rawQuery("SELECT * FROM Menu WHERE category=?", ['Cake']);
    return cake.map((e) => MenuModel.fromJson(e)).toList();
  }

  Future<List<MenuModel>> smoothiedata() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic>> data =
        await db.rawQuery("SELECT * FROM Menu WHERE category=?", ['Smoothie']);
    return data.map((e) => MenuModel.fromJson(e)).toList();
  }

  Future<List<MenuModel>> nowServeData() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic>> nowserve =
        await db.rawQuery("SELECT * FROM Menu WHERE category=?", ['Nowserve']);
    return nowserve.map((e) => MenuModel.fromJson(e)).toList();
  }

  Future<List<MenuModel>> offersData() async {
    final Database db = await initDBMenu();
    final List<Map<String, dynamic>> offerlist =
        await db.rawQuery("SELECT * FROM Menu WHERE category=?", ['Offers']);
    return offerlist.map((e) => MenuModel.fromJson(e)).toList();
  }

  Future<List<MenuModel>> getElementOnIdMenu(getit) async {
    final db = await initDBMenu();
    final List<Map<String, dynamic>> maps =
        await db.query('Menu', where: "id = ?", whereArgs: [getit]);
    return List.generate(
      maps.length,
      (i) {
        return MenuModel(
          id: maps[i]['id'],
          tag: maps[i]['tag'],
          title: maps[i]['title'],
          price: maps[i]['price'],
          description: maps[i]['description'],
          category: maps[i]['category'],
          image: maps[i]['image'],
          rating: maps[i]['rating'],
          quantity: maps[i]['quantity'],
          calories: maps[i]['calories'],
        );
      },
    );
  }

  Future<List<MenuModel>> getItemWithIdOrder(getit) async {
    final db = await initDBMenu();
    final List<Map<String, dynamic>> maps =
        await db.query('Menu', where: "id = ?", whereArgs: [getit]);
    var res = List.generate(
      maps.length,
      (i) {
        return MenuModel(
            id: maps[i]['id'],
            tag: maps[i]['tag'],
            title: maps[i]['title'],
            price: maps[i]['price'],
            description: maps[i]['description'],
            category: maps[i]['category'],
            image: maps[i]['image'],
            rating: maps[i]['rating'],
            quantity: maps[i]['quantity'],
            calories: maps[i]['calories']);
      },
    );
    return res;
  }
}
