import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hexcolor/hexcolor.dart';

import '../home/home_screen.dart';
import '../model/cart_model.dart';
import '../model/menu_model.dart';
import '/db/cart_db.dart';
import '/db/menu_db.dart';

class GetCoffeeData extends StatefulWidget {
  const GetCoffeeData({Key? key}) : super(key: key);

  @override
  State<GetCoffeeData> createState() => _GetCoffeeDataState();
}

class _GetCoffeeDataState extends State<GetCoffeeData> {
  late MenuDB menuDB;
  bool getdataf = false;
  List<MenuModel> data = [];

  late CartDB cdb;
  @override
  void initState() {
    cdb = CartDB();
    cdb.initDBCart();
    getCartData1();
    menuDB = MenuDB();
    menuDB.initDBMenu();
    getMenuData_coffee();
    super.initState();
  }

  addToCartCoffee(context, index) async {
    late MenuDB db;
    db = MenuDB();
    final cartp = await db.coffeedata();

    var zindex = data.indexWhere((item) => item.id == cartp[index].id);
    if (zindex != -1) {
      cdb.insertDataCart(
        CartModel(id: cartp[index].id, qty: 1),
      );
    } else {
      print('already added');
    }
    setState(() {});
  }

  List<CartModel> cartData = [];
  getCartData1() async {
    cartData = await cdb.getDataCart();
    setState(() {});
  }

  getMenuData_coffee() async {
    data = await menuDB.coffeedata();
    setState(() {
      getdataf = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("Len of cart" + cartData.length.toString());
    for (int i = 0; i < cartData.length; i++) {
      // print("Ids in cart ");
      // print(cartData[i].id);
    }
    // print('items in db: ' + data.length.toString());
    return Scaffold(
      // persistentFooterButtons: cartinit ? [viewincart()] : null,
      body: getdataf
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // getcoffeedetails(context, index);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              color: HexColor("#175244"), width: 0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start, //change here don't //worked
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10, bottom: 20),
                          transform: Matrix4.translationValues(-10, 20, 0),
                          child: Image.asset(
                            data[index].image,
                            width: 150,
                            height: 150,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AutoSizeText(
                                data[index].title,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                maxFontSize: 18,
                                maxLines: 1,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                              Text(
                                " \$ " + data[index].price,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.06,
                              ),
                              Row(
                                children: <Widget>[
                                  AutoSizeText(
                                    data[index].rating,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    minFontSize: 12,
                                    maxFontSize: 18,
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.amberAccent,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.22),
                                    child: TextButton(
                                      onPressed: () {
                                        addToCartCoffee(context, index);
                                        setState(() {
                                          cartinit = true;
                                        });
                                      },
                                      child: Text('Add'),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                index % 2 == 0
                                                    ? Colors.teal
                                                    : Colors.deepOrangeAccent),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : CircularProgressIndicator(),
    );
  }
}
