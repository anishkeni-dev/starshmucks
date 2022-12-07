import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;
import '../common_things.dart';
import '../db/user_db.dart';
import '../model/menu_model.dart';
import '../providers/learnmore_provider.dart';
import 'now_serving.dart';
import 'offers_data.dart';
import '/db/menu_db.dart';
import '/rewards.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool cartinit = false;
late String username;

class _HomePageState extends State<HomePage> {
  late MenuDB db;
  List<MenuModel> data = [];
  List<Map<String, dynamic>> userddt = [];
  late var product;
  late UserDB udb;
  void initState() {
    udb = UserDB();
    udb.initDBUserData();
    getUser();
    db = MenuDB();
    db.initDBMenu();
    getdata();
    putdata();

    // setUserForLogin();
    super.initState();
  }

  List<Map<String, dynamic>> usernames = [];
  getUser() async {
    usernames = await udb.getDataUserData();
    setState(() {});
  }

  getdata() async {
    data = await db.getDataMenu();
    setState(() {});
  }

  putdata() async {
    final String response =
        await DefaultAssetBundle.of(context).loadString("json/menu.json");
    final responseData = jsonDecode(response);
    for (var item = 0; item < responseData['Menu'].length; item++) {
      product = MenuModel.fromJson(responseData['Menu'][item]);
      db.insertDataMenu(product);
    }
  }

  setUserForLogin(email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('signedInEmail', email);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (usernames.isEmpty)
      return CircularProgressIndicator(backgroundColor: HexColor("#175244"));
    else {
      username = usernames[0]['name'];
      String email = usernames[0]['email'];
      setUserForLogin(email);
      initcart();
      return Scaffold(
          persistentFooterButtons: cartinit ? [viewincart()] : null,
          body: SingleChildScrollView(
            child: Column(
              children: [
                getbanner(context, username),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Offers',
                    style: TextStyle(
                      color: HexColor("#175244"),
                      fontWeight: FontWeight.w700,
                    ),
                    minFontSize: 25,
                  ),
                ),
                const GetOffers(),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Now Serving',
                    style: TextStyle(
                      color: HexColor("#175244"),
                      fontWeight: FontWeight.w700,
                    ),
                    minFontSize: 25,
                  ),
                ),
                const NowServing(),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Learn More About Our Drinks',
                    style: TextStyle(
                      color: HexColor("#175244"),
                      fontWeight: FontWeight.w700,
                    ),
                    minFontSize: 25,
                  ),
                ),
                learnmore(context),
              ],
            ),
          ));
    }
  }
}

getbanner(context, username) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.2,
    decoration: BoxDecoration(
      color: HexColor("#175244"),
      image: DecorationImage(
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.05),
          BlendMode.dstATop,
        ),
        image: const ExactAssetImage('images/shmucks.png'),
      ),
    ),
    child: Column(
      children: [
        Container(
          transform: Matrix4.translationValues(0, 28, 0),
          child: Text(
            '${'Hi ' + username}!',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 20,
            left: 20,
          ),
          transform: Matrix4.translationValues(
            0,
            80,
            0,
          ),
          child: Row(
            children: [
              Container(
                transform: Matrix4.translationValues(
                  3,
                  -8,
                  0,
                ),
                child: Image.asset(
                  'images/stars.png',
                  width: 20,
                ),
              ),
              Column(
                children: const [
                  AutoSizeText(
                    '1/5',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    minFontSize: 12,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 2.0,
                      left: 8,
                    ),
                    child: AutoSizeText(
                      'Stars',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      minFontSize: 12,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                transform: Matrix4.translationValues(
                  0,
                  -8,
                  0,
                ),
                child: const Icon(
                  Icons.card_giftcard,
                  color: Colors.amber,
                  size: 13,
                ),
              ),
              Column(
                children: [
                  Container(
                    transform: Matrix4.translationValues(
                      -18,
                      0,
                      0,
                    ),
                    child: const AutoSizeText(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      minFontSize: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 2.0,
                      left: 8,
                    ),
                    child: AutoSizeText(
                      'Rewards',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      minFontSize: 12,
                    ),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                transform: Matrix4.translationValues(
                  30,
                  4,
                  0,
                ),
                child: const AutoSizeText(
                  'You are 4 stars away from another reward',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  minFontSize: 15,
                ),
              ),
              Container(
                transform: Matrix4.translationValues(
                  15,
                  5,
                  0,
                ),
                child: IconButton(
                  onPressed: () {
                    Get.to(const Rewards());
                  },
                  icon: const Icon(
                    Icons.play_arrow_sharp,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

learnmore(context) {
  final learnmorep = Provider.of<Learnmore>(context);
  learnmorep.fetchData(context);
  return SizedBox(
    height: 250,
    child: ListView.builder(
      itemCount: learnmorep.learnmore.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HexColor('#ebd8a7'),
                  Colors.white,
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.42,
            width: MediaQuery.of(context).size.width * 0.86,
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    learnmorep.learnmore[index].image,
                    width: 250,
                  ),
                ),
                Container(
                  child: Container(
                    child: Text(
                      learnmorep.learnmore[index].title,
                      style: TextStyle(
                        color: HexColor('#175244'),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    learnmorep.learnmore[index].tag,
                    style: TextStyle(
                      color: HexColor('#175244'),
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
