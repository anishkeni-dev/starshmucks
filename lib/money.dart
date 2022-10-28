import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'commonthings.dart';
import 'home_screen.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethomeappbar(),
      floatingActionButton: orderbutton(),
      bottomNavigationBar: getbottombar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}