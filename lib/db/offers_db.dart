import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/nowserving_model.dart';
import '../model/offers_model.dart';

class OffersDb {


  Future<Database> initOffersdb() async {
    print("initialising db...");
    String databasepath = await getDatabasesPath();
    final path = join(databasepath, "Offers3.db");
    return openDatabase(path,
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE IF NOT EXISTS Offers(
          id INTEGER PRIMARY KEY,
          title TEXT NOT NULL,
          tag TEXT NOT NULL,
          desc TEXT NOT NULL,
          image TEXT NOT NULL,
          rating TEXT NOT NULL,
          price TEXT NOT NULL,
          category TEXT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }
  Future<bool> insertOffersData(Offer offers) async{
    final Database db = await initOffersdb();
    db.insert("Offers", offers.toMap());
    return true;
  }

  Future<List<Offer>> getOffersdata() async{
    final Database db = await initOffersdb();
    final List<Map<String,dynamic>> data = await db.query("Offers");
    return data.map((e) => Offer.fromJson(e)).toList();
  }
  Future<List<Offer>> Offersdata() async{
    final Database db = await initOffersdb();
    final List<Map<String,dynamic>> offerlist = await db.rawQuery("SELECT * FROM Offers WHERE category=?", ['offers']);
    return offerlist.map((e) => Offer.fromJson(e)).toList();
  }
}


