import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hexcolor/hexcolor.dart';

import '../boxes.dart';
import '../common_things.dart';

import '../home_screen.dart';
import '../model/cartDBModel.dart';
import '../model/cart_model.dart';
import '../model/menu_model.dart';
import '/db/cart_db.dart';
import '/db/menu_db.dart';

class getcakedata extends StatefulWidget {
  const getcakedata({Key? key}) : super(key: key);

  @override
  State<getcakedata> createState() => _getcakedataState();
}

class _getcakedataState extends State<getcakedata> {
  addToCart(context, index) async {
    print("in cart " + index.toString());
    final box = Boxes.getCartData();
    final data = box.values.toList().cast<CartData>();
    final cartp = await db.cakedata();

    cdb.insertDataCart(
      CartModel(id: cartp[index].id),
    );
    final cartItem = CartData()
      ..title = cartp[index].title
      ..price = cartp[index].price
      ..qty = 1
      ..isInCart = true
      ..image = cartp[index].image
      ..ttlPrice = 0.0
      ..id = cartp[index].id;

    var zindex = data.indexWhere((item) => item.id == cartp[index].id);
    print("test " + zindex.toString());
    if (zindex != -1) {
      data[zindex].qty++;
      box.putAt(zindex, data[zindex]);
      print("already inn");
    } else {
      box.add(cartItem);
      print(cartItem.title);
    }
    setState(() {});
  }

  late MenuDB db;
  bool getdataf = false;
  List<Menu> data = [];

  late CartDB cdb;

  @override
  void initState() {
    cdb = CartDB();
    cdb.initDBCart();

    db = MenuDB();
    db.initDBMenu();
    getdata();
    super.initState();
  }

  getdata() async {
    data = await db.cakedata();
    setState(() {
      getdataf = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('items in db: ' + data.length.toString());
    return Scaffold(
      persistentFooterButtons: cartinit ? [viewincart()] : null,
      body: getdataf
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                print(data[0].title);
                return GestureDetector(
                  onTap: () {
                    //getcoffeedetails(context, index);
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
                                        addToCart(context, index);
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