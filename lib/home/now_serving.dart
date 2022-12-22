import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '/databse/menu_db.dart';
import '../common_things.dart';
import '../databse/cart_db.dart';
import '../databse/wishlist_db.dart';
import '../model/menu_model.dart';
import '../model/wishlist_model.dart';
import '../productdetail.dart';
import 'home_screen.dart';

class NowServing extends StatefulWidget {
  const NowServing({Key? key}) : super(key: key);

  @override
  State<NowServing> createState() => _NowServingState();
}

class _NowServingState extends State<NowServing> {
  late MenuDB db;
  bool getdataf = false;
  List<MenuModel> nowdata = [];
  late var product;

  late CartDB cdb;
  late WishlistDB wdb;
  late FToast fToast;

  @override
  void initState() {
    cdb = CartDB();
    cdb.initDBCart();
    db = MenuDB();
    db.initDBMenu();
    wdb = WishlistDB();
    wdb.initDBWishlist();
    getIds();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

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

  removefromwishlist(sendid) {
    wdb.deleteitemFromWishlist(sendid);
    getIds();
  }

  addToWishlist(context, index) async {
    final cartp = await db.nowServeData();
    wdb.insertDataWishlist(WishlistModel(id: cartp[index].id));
    getIds();
  }

  getdata() async {
    nowdata = await db.nowServeData();
    if (mounted) {
      setState(() {
        getdataf = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.18,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: nowdata.length,
        itemBuilder: (context, index) {
          bool status = false;
          for (var i = 0; i < ids.length; i++) {
            if (ids[i] == nowdata[index].id) status = true;
          }
          return Row(
            children: [
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  getpdata(nowdata[index]);
                  Get.to(() => const ProductDetail(),
                      transition: Transition.downToUp);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        index % 2 == 0 ? Colors.deepOrangeAccent : Colors.teal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.76,
                  child: Stack(
                    children: [
                      Container(
                        transform: Matrix4.translationValues(-10, 20, 0),
                        child: Image.asset(
                          nowdata[index].image,
                          width: 150,
                          height: 150,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                          left: 130,
                        ),
                        child: Text(
                          nowdata[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30,
                          left: 130,
                        ),
                        child: Text(
                          nowdata[index].tag,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Container(
                        // transform: Matrix4.translationValues(-320, 40, 0),
                        margin: const EdgeInsets.only(
                          top: 85,
                          left: 190,
                        ),
                        child: TextButton(
                          onPressed: () {
                            addToCart(nowdata[index].id);
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
                          child: const Text('Add'),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          status
                              ? removefromwishlist(
                                  WishlistModel(id: nowdata[index].id))
                              : addToWishlist(context, index);
                        },
                        icon: status
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.white,
                              )
                            : const Icon(Icons.favorite_border,
                                color: Colors.white),
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
