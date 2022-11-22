import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';

import '/db/cart_db.dart';
import '/model/cart_model.dart';
import 'boxes.dart';
import 'address.dart';
import 'db/menu_db.dart';
import 'model/menu_model.dart';
import 'model/user_model.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  bool ischecked = false;
  var result;
  @override
  getcarttotal() {
    // final box = Boxes.getCartData();
    // final data = box.values.toList().cast<CartData>();
    // late double result = 0;
    // for (int index = 0; index < data.length; index++) {
    //   result = result + double.parse(data[index].price) * data[index].qty;
    // }
    // setState(() {});
    // return result;
  }

  late CartDB cartdb;
  late MenuDB menudb;
  List<MenuModel> kart = [];
  List<MenuModel> kart1 = [];
  List<CartModel> idlist = [];

  @override
  clearcart() {
    cartdb.clear();
  }

  void initState() {
    menudb = MenuDB();
    menudb.initDBMenu();
    cartdb = CartDB();
    cartdb.initDBCart();
    result = getcarttotal();
    getDataOnIds();
    super.initState();
  }

  getDataOnIds() async {
    idlist = await cartdb.getDataCart();
    print("size" + idlist.length.toString());
    // kart= await menudb.ffeedata(1); // prints product at id 1
    //logic for sending ids from cart list to get details from menu db
    for (var i = 0; i < idlist.length; i++) {
      kart = await menudb.getElementOnId_Menu(idlist[i].id);
      print("init cart " + kart.length.toString());
      if (kart.length == 1) kart1.add(kart.first);

      //print("fdg " + kart.runtimeType.toString());
      print("added to cart: " + kart1.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final box2 = Boxes.getUserData();
    final data2 = box2.values.toList().cast<UserDataModel>();

    // final box = Boxes.getCartData();
    // final data = box.values.toList().cast<CartData>();
    return Scaffold(
      bottomNavigationBar:
          //
          // data.isEmpty
          //     ? Center(child: Text("No items in cart"))
          Container(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Get.to(Address(), transition: Transition.rightToLeft);
          },
          child: Text("Checkout"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(HexColor("#036635"))),
          //   ),
          // ],
        ),
      ),

      // })),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: HexColor("#175244"),
        title: Text("Cart"),
        elevation: 2,
        actions: [
          IconButton(
            color: HexColor("#175244"),
            onPressed: () {
              clearcart();
            },
            icon: const Icon(
              Icons.clear,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: kart1.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8,
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      kart1[index].image,
                      height: 100,
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 150,
                              child: Text(kart1[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis)),
                          Text("\$ " + kart1[index].price),
                          TextButton(
                            onPressed: () {
                              // box.delete(data[index].key);
                              // data[index].isInCart = false;
                              setState(() {});
                            },
                            style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(
                                    HexColor("#036635"))),
                            child: Text(
                              'Remove',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                // if (data[index].qty == 1) {
                                //   box.delete(data[index].key);
                                //   data[index].isInCart = false;
                                // } else {
                                //   data[index].qty = data[index].qty - 1;
                                //   box.putAt(index, data[index]);
                                // }
                                setState(() {});
                              },
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      HexColor("#036635"))),
                            ),
                            // Text(data[index].qty.toString()),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                // data[index].qty = data[index].qty + 1;
                                // box.putAt(index, data[index]);
                                setState(() {});
                              },
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      HexColor("#036635"))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
