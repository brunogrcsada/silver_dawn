import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:silver_dawn/customers.dart';
import 'dart:typed_data';
import 'package:path/path.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static Database _database;

  Database customersDatabase;

  String customerTable = 'customer';

  String customerID = 'customer_id';
  String firstName = 'first_name';
  String lastName = 'last_name';
  String address = 'address';
  String postCode = 'post_code';
  String email = 'email';
  String phoneNumber = 'phone_number';
  String requirements = 'requirements';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "silver_dawn.db");

    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "silver_dawn.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }
// open the database
    var customersDatabase = await openDatabase(path, version: 1);
    return customersDatabase;
  }


  Future<List<Map<String, dynamic>>> getCustomerMapList() async {
    Database db = await this.database;
    var result = await db.query(customerTable, orderBy: '$firstName ASC');
    return result;
  }

  Future<int> insertCustomer(Customers customer) async {
    Database db = await this.database;
    var result = await db.insert(customerTable, customer.toMap());

    return result;
  }

  Future<int> updateCustomer(Customers customer) async {
    var db = await this.database;
    var result = await db.update(customerTable, customer.toMap(), where: '$customerID = ?', whereArgs: [customer.customerID]);
    return result;
  }

  Future<int> deleteCustomer(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $customerTable WHERE $customerID = $id');
    return result;
  }

  Future<int> getCustomerCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $customerTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Customers>> getCustomerList() async {

    var customerMapList = await getCustomerMapList();
    int count = customerMapList.length;

    List<Customers> customerList = List<Customers>();
    for (int i = 0; i < count; i++) {
      customerList.add(Customers.fromMapObject(customerMapList[i]));
    }

    return customerList;
  }

}