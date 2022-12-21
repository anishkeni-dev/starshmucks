import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '/common_things.dart';
import '/model/wishlist_model.dart';
import '/productdetail.dart';
import '../databse/cart_db.dart';
import '../databse/menu_db.dart';
import '../databse/wishlist_db.dart';
import '../model/cart_model.dart';
import '../model/menu_model.dart';
import 'home_screen.dart';

class GetOffers extends StatefulWidget {
  const GetOffers({Key? key}) : super(key: key);

  @override
  State<GetOffers> createState() => _GetOffersState();
}

class _GetOffersState extends State<GetOffers> {
  late MenuDB db;
  bool getdataf = false;
  List<MenuModel> odata = [];
  late var product;
  late FToast fToast;
  late CartDB cdb;
  late WishlistDB wdb;
  late List<int> ids = [];

  getIds() async {
    ids.clear();
    late List<WishlistModel> datalist = [];
    datalist = await wdb.getDataWishlist();
    for (var i = 0; i < datalist.length; i++) {
      ids.add(datalist[i].id);
    }
    setState(() {});
  }

  @override
  void initState() {
    cdb = CartDB();
    cdb.initDBCart();
    db = MenuDB();
    db.initDBMenu();
    wdb = WishlistDB();
    wdb.initDBWishlist();
    getdata();
    getIds();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  getdata() async {
    odata = await db.offersData();

    if (mounted) {
      setState(() {
        getdataf = true;
      });
    }
  }

  addToCart(context, index) async {
    final cartp = await db.offersData();
    cdb.insertDataCart(CartModel(id: cartp[index].id, qty: 1));
  }

  addToWishlist(context, index) async {
    final cartp = await db.offersData();
    wdb.insertDataWishlist(WishlistModel(id: cartp[index].id));
    getIds();
  }

  removefromwishlist(sendid) async {
    wdb.deleteitemFromWishlist(sendid);
    await getIds();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.18,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: odata.length,
        itemBuilder: (context, index) {
          ValueNotifier<bool> real = ValueNotifier<bool>(false);
          for (var i = 0; i < ids.length; i++) {
            if (ids[i] == odata[index].id) real.value = true;
          }
          return Row(
            children: [
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  getpdata(odata[index]);
                  Get.to(() => const ProductDetail(),
                      transition: Transition.rightToLeftWithFade);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        index % 2 == 0 ? Colors.teal : Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.76,
                  child: Stack(
                    children: [
                      Container(
                        transform: Matrix4.translationValues(-10, 20, 0),
                        child: Image.asset(odata[index].image,
                            width: 150, height: 150),
                      ),
                      Container(
                        // transform: Matrix4.translationValues(-120, 10, 0),
                        margin: EdgeInsets.only(
                          top: Platform.isIOS ? 0 : 10,
                          left: 130,
                        ),
                        child: Text(
                          odata[index].tag,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: Platform.isIOS ? 40 : 30,
                          left: 130,
                        ),
                        child: Text(
                          odata[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 85,
                          left: 190,
                        ),
                        child: TextButton(
                          onPressed: () {
                            addToCart(context, index);
                            String toastMessage = "ITEM ADDED TO CART";
                            fToast.showToast(
                              child: CustomToast(toastMessage),
                              positionedToastBuilder: (context, child) =>
                                  Positioned(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.14,
                                left: MediaQuery.of(context).size.width * 0.1,
                                right: MediaQuery.of(context).size.width * 0.1,
                                child: child,
                              ),
                            );
                            setState(() {
                              cartinit = true;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                HexColor('#175244')),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                          child: const Text("Add"),
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: real,
                        builder: (context, value, child) => IconButton(
                          onPressed: () {
                            //int id = odata[index].id;
                            real.value
                                ? removefromwishlist(
                                    WishlistModel(id: odata[index].id))
                                : addToWishlist(context, index);
                          },
                          icon: Icon(
                            real.value ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
