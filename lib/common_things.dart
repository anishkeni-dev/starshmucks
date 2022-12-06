import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/db/cart_db.dart';
import 'db/user_db.dart';
import 'home/home_screen.dart';
import '/user_profile.dart';
import 'cart.dart';
import 'gift_card.dart';
import 'menu/menu_page.dart';
import 'model/user_model.dart';
import 'order/order_failed.dart';
import 'order/order_success.dart';
import '/model/cart_model.dart';
import 'wishlist.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  State<bottomBar> createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    HomePage(),
    GiftCard(),
    OrderPage(),
    UserProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethomeappbar(),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: HexColor("#175244")),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.card_giftcard,
              color: HexColor("#175244"),
            ),
            label: 'Gift',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: HexColor("#175244")),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: HexColor("#175244")),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: HexColor("#175244"),
        onTap: _onItemTapped,
      ),
    );
  }
}

orderbutton() {
  return FloatingActionButton(
    //Floating action button on Scaffold
    elevation: 10,
    backgroundColor: Color(0xffb036635),
    onPressed: () {
      Get.to(OrderPage(), transition: Transition.downToUp);
    },
    child: Icon(
      Icons.coffee_maker_outlined,
      color: Colors.white,
    ), //icon inside button
  );
}

gethomeappbar() {
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(
      'Starschmucks',
      style: TextStyle(
        color: HexColor("#175244"),
        fontWeight: FontWeight.w600,
      ),
    ),
    elevation: 0,
    actions: [
      IconButton(
        color: HexColor("#175244"),
        onPressed: () {
          Get.to(WishListPage());
        },
        icon: const Icon(
          Icons.favorite,
        ),
      ),
    ],
    automaticallyImplyLeading: false,
  );
}

late double ttl = 0;
late double savings = 0;
late var size = 0;
getdata() async {
  CartDB cdb = CartDB();
  List<CartModel> data = await cdb.getDataCart();
  size = data.length;
}

getttl()async{
  final total = await SharedPreferences.getInstance();
  ttl = total.getDouble('total')!;
  savings = total.getDouble('savings')!;
}
viewincart(){
  getttl();
  getdata();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        children: [
          Text(
            size.toString(),
            style: TextStyle(
                color: HexColor("#036635"), fontWeight: FontWeight.w600),
          ),
          if (size < 2)
            Text(
              " item | ",
              style: TextStyle(color: HexColor("#036635")),
            )
          else
            Text(
              " items | ",
              style: TextStyle(color: HexColor("#036635")),
            ),
          Text(
            "\$" + ttl.toStringAsFixed(2),
            style: TextStyle(
                color: HexColor("#036635"), fontWeight: FontWeight.w600),
          ),
        ],
      ),
      TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color?>(HexColor("#036635")),
            foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
          ),
          child: Text(
            "View in Cart",
          ),
          onPressed: () {
            Get.to(MyCart(), transition: Transition.downToUp);
          }),
    ],
  );
}
initcart()async{
  CartDB cdb = CartDB();
  cdb.initDBCart();
  List<CartModel>datal = await cdb.getDataCart();
  datal.isEmpty?cartinit = false:cartinit=true;
}

Future<bool> gohome() async {
  return (await Get.to(bottomBar())) ?? false;
}

Future<bool> gohomefromsuccess() async {
  calcrewards();
  CartDB cartdb = CartDB();
  cartdb.clear();
  return (await Get.to(bottomBar())) ?? false;
}

goToSuccess() {
  return Get.to(OrderSuccess());
}

goToFailed(String message) {
  return Get.to(OrderFail(message));
}

calcrewards() async {
  UserDB udb = UserDB();
  List<Map<String, dynamic>> usernames = [];
  usernames = await udb.getDataUserData();
  print("rewards used: "+savings.toString());
  double res  = usernames[0]['rewards'] + (ttl/10) - (savings*2);
  print("final rewards todb = "+ res.toString());

  var rewardUpdate = UserModel(
    rewards:res,
    tier: usernames[0]['tier'],
    dob: usernames[0]['dob'],
    email: usernames[0]['email'],
    name: usernames[0]['name'],
    password: usernames[0]['password'],
    phone: usernames[0]['phone'],
    tnc: usernames[0]['tnc'], image: usernames[0]['image'],
    // addressID: ,
  );
  print(usernames[0]['rewards']);
  udb.updaterewards(rewardUpdate);
}

class CustomToast extends StatelessWidget {
  const CustomToast(
    String this.toastMessage,
  );
  final String toastMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: HexColor("#036635"),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            toastMessage,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
