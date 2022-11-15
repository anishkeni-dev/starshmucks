import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:starshmucks/common_things.dart';
import 'package:starshmucks/home_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

import 'boxes.dart';
import 'model/cart_model.dart';

class Ordersuccess extends StatefulWidget {
  Ordersuccess({Key? key}) : super(key: key);

  @override
  _OrdersuccessState createState() => _OrdersuccessState();
}

class _OrdersuccessState extends State<Ordersuccess> {
  @override
  void initState() {
    getAddress();
    super.initState();
    cartinit = false;
  }

  late String selectedAddress = '';
  getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedAddress = prefs.getString("selectedAddress")!;
    setState(() {});
    print("test " + selectedAddress);
    return selectedAddress;
  }

  @override
  Widget build(BuildContext context) {
    final box = Boxes.getCartData();
    final data = box.values.toList().cast<CartData>();
    return WillPopScope(
      onWillPop: gohome,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  icon: Icon(Icons.arrow_back, color:HexColor("#175244") ,),
                  label: Text(''),
                  onPressed: () {
                    Get.to(bottomBar());
                  },
                ),
                TextButton(child: Text('Help', style: TextStyle(color: HexColor("#175244")),), onPressed: (){},),
              ],
            ),
            backgroundColor: Colors.white,
            foregroundColor: HexColor("#175244"),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    color: HexColor("#175244"),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.05),
                        BlendMode.dstATop,
                      ),
                      image: ExactAssetImage('images/shmucks.png'),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        transform: Matrix4.translationValues(0, 28, 0),
                        child: Text(
                          'Order Placed!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ),
                      Container(
                          transform: Matrix4.translationValues(0, 40, 0),
                          child: AutoSizeText(
                            'Your order will take 30-35mins',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Order details",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                Divider(
                    color: HexColor("#175244"),
                    height: 1,
                    thickness: 0.5,
                    indent: 0,
                    endIndent: 0,
                  ),

                ValueListenableBuilder<Box<CartData>>(
                    valueListenable: Boxes.getCartData().listenable(),
                    builder: (context, box, _) {
                      final data = box.values.toList().cast<CartData>();
                      if (data.isEmpty) {
                        cartinit = false;
                      }
                      return data.isEmpty
                          ? Center(child: Text("No items in cart"))
                          : SizedBox(
                              width: 400,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width: 150,
                                                    child: Text(data[index].title,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis)),
                                                Text(data[index].qty.toString() +
                                                    ' x qty'),
                                              ],
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(children: [
                                                    AutoSizeText(
                                                      "\$ " + data[index].price,
                                                      minFontSize: 10,
                                                    ),
                                                  ]),
                                                ])
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Divider(
                    color: HexColor("#175244"),
                    height: 1,
                    thickness: 0.5,
                    indent: 0,
                    endIndent: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cart total",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "\$ " + data[userkey].ttlPrice.toStringAsFixed(2),
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Points savings",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(
                            '-\$ 10.00',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery fee",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(
                            "\$ 5.00",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "\$ " +
                                (data[userkey].ttlPrice - 10.0 + 5.00).toString(),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Divider(
                    color: HexColor("#175244"),
                    height: 1,
                    thickness: 0.5,
                    indent: 0,
                    endIndent: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Deliver to:",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        selectedAddress.toString(),
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    );
  }
}
