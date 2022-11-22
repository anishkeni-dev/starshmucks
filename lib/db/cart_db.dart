import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:starshmucks/model/cartDBModel.dart';
import '../model/menu_model.dart';
import 'menu_db.dart';

class CartDB {
  Future<Database> initDBCart() async {
    print("initialising db Cart");
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "Cart.db");
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS CartTable(
          id INT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertDataCart(CartModel item) async {
    final Database db = await initDBCart();
    db.insert("CartTable", item.toMap());
    print("inserted in cart");

    //db.delete("CartTable");
    return true;
  }

  Future<List<CartModel>> getDataCart() async {
    final Database db = await initDBCart();
    final List<Map<String, dynamic?>> data = await db.query("CartTable");
    print("after query");
    print(data.length);
    return data.map((e) => CartModel.fromJson(e)).toList();
  }

  //temp
  clear() async {
    final Database db = await initDBCart();
    db.delete("CartTable");
  }
}
