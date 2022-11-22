import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '/order/smoothie_data.dart';
import '../db/menu_db.dart';
import '../model/menu_model.dart';
import 'cake_data.dart';
import 'coffee_data.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController tabController;
  late MenuDB db;
  bool fetching = false;
  late var product;
  List<Menu> data = [];
  //
  // late CartDB cdb;
  @override
  void initState() {
    db = MenuDB();
    db.initDBMenu();
    getdata();
    putdata();
    // cdb = CartDB();
    // cdb.initDBCart();
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  getdata() async {
    data = await db.getDataMenu();
    setState(() {
      fetching = true;
    });
  }

  putdata() async {
    final String response =
        await DefaultAssetBundle.of(context).loadString("json/menu.json");
    final responseData = jsonDecode(response);
    for (var item = 0; item < responseData['Menu'].length; item++) {
      product = Menu.fromJson(responseData['Menu'][item]);
      // print('adding ' + responseData['Menu'][item].toString());
      if (data.isNotEmpty && data.contains(product)) {
        //  print('items already exists');
      } else {
        db.insertDataMenu(product);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final menup = Provider.of<Menudata>(context);//
    // menup.cakefetchData(context);
    // menup.coffeefetchData(context);
    // menup.smoothiefetchData(context);
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            TabBar(
              controller: tabController,
              indicatorColor: HexColor("#175244"),
              tabs: <Widget>[
                Tab(
                  icon: Icon(
                    Icons.coffee,
                    color: HexColor("#175244"),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.cake_outlined,
                    color: HexColor("#175244"),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.local_drink_sharp,
                    color: HexColor("#175244"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  getcoffeedata(),
                  getcakedata(),
                  getsmoothiedata(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
