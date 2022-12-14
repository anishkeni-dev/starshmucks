import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starshmucks/db/user_db.dart';

import '/db/menu_db.dart';
import '/db/orders_db.dart';
import '/model/menu_model.dart';
import '/model/order_history.dart';
import '../help_page.dart';

class Orderdetail extends StatefulWidget {
  const Orderdetail({Key? key}) : super(key: key);

  @override
  State<Orderdetail> createState() => _OrderdetailState();
}

class _OrderdetailState extends State<Orderdetail> {
  late OrdersDB orderdb;
  late int? id = 0;
  List<OrderHistoryModel> orderdata = [];
  List<dynamic> idlistfromstring = [];
  List<dynamic> qtylistfromstring = [];
  List<MenuModel> items = [];
  List<MenuModel> items1 = [];
  late double ttl = 0;
  late double cartttl = 0;
  late double savings = 0;
  double delchar = 5;
  UserDB udb = UserDB();

  @override
  void initState() {
    getOrderId();
    getUser();
    getAddress();

    super.initState();
  }

  List<Map<String, dynamic>> userddt = [];

  getUser() async {
    userddt = await udb.getDataUserData();
    setState(() {});
  }

  getTotal() async {
    final total = await SharedPreferences.getInstance();
    savings = total.getDouble('savings')!;
    for (var i = 0; i < items1.length; i++) {
      cartttl = cartttl + double.parse(items1[i].price);
    }
    if (userddt[0]['tier'] == 'bronze') {
      ttl = (cartttl + delchar) - savings;
    } else if (userddt[0]['tier'] == 'silver') {
      if (cartttl > 50.0) {
        ttl = (cartttl) - savings;
      } else {
        ttl = (cartttl + delchar) - savings;
      }
    } else {
      ttl = (cartttl) - savings;
    }
  }

  getOrderId() async {
    final prefs = await SharedPreferences.getInstance();
    id = (await prefs.getInt('orderid'))!;
    await getOrderDetails(id);
    setState(() {});
  }

  getOrderDetails(id) async {
    MenuDB menuDb = MenuDB();
    menuDb.initDBMenu();

    orderdb = OrdersDB();
    orderdb.initDBOrders();
    orderdata = await orderdb.getDataOrderswrtID(id);
    for (var i = 0; i < orderdata.length; i++) {
      idlistfromstring = orderdata[i].id!.split(' ');
      qtylistfromstring = orderdata[i].qty!.split(' ');
    }
    for (var i = 0; i < idlistfromstring.length; i++) {
      items = await menuDb.getitemwithId_order(idlistfromstring[i]);
      items1.add(items.first);
    }
    getTotal();
    setState(() {});
  }

  late String selectedAddress = '';

  getAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedAddress = prefs.getString("selectedAddress")!;
    setState(() {});

    return selectedAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            backgroundColor: Colors.white,
            foregroundColor: HexColor("#175244"),
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Order id: #$id',
                  style: TextStyle(
                    color: HexColor("#175244"),
                  )),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    orderdata.isEmpty ||
                            items1.isEmpty ||
                            qtylistfromstring.isEmpty
                        ? const Center(
                            child: Text('updating...'),
                          )
                        : Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 1,
                            child: Card(
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Deliver To",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey,
                                        fontSize: 18),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'images/map.png',
                                          height: 100,
                                          width: 100,
                                          alignment: Alignment.centerLeft,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child:
                                          Text(
                                            selectedAddress,
                                            softWrap: false,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16)//new
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      width: MediaQuery.of(context).size.width * 1,
                      child: Card(
                        elevation: 8,
                        child:Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Order Summary",
                                  style: TextStyle(fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.date_range_outlined,
                                      size: 20.0,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${orderdata[0].date}",
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    // Text(
                                    //   "items: ${idlistfromstring.length}",
                                    //   style:
                                    //   const TextStyle(fontSize: 13),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                            ListView.builder(
                              physics:
                              const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: qtylistfromstring.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    qtylistfromstring.isEmpty ||
                                        items1.isEmpty
                                        ? const Center(
                                      child: Text('updating...'),
                                    )
                                        : Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        SizedBox(
                                            width: 150,
                                            child: Text(
                                                items1[index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow:
                                                TextOverflow
                                                    .ellipsis)),
                                        Text(
                                            qtylistfromstring[
                                            index] +
                                                ' x qty'),
                                      ],
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Row(children: [
                                            Text(
                                              "\$ ${items1[index].price}",
                                            ),
                                          ]),
                                        ])
                                  ],
                                );
                              },
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Subtotal",
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\$ ${cartttl.toStringAsFixed(2)}",
                                  style: const TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Points savings",
                                  style:
                                  TextStyle(fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  '- \$ $savings',
                                  style:
                                  const TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Delivery Charges",
                                  style:
                                  TextStyle(fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  "\$ 5.00",
                                  style:
                                  TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total",
                                  style:
                                  TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "\$ ${ttl.toStringAsFixed(2)}",
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ],
                        ),
                        )
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const Help());
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                        ),
                        width: MediaQuery.of(context).size.width * 1,
                        child: Card(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text(
                                  "Need Help?",
                                  style: TextStyle(
                                      color: HexColor("#175244"),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

