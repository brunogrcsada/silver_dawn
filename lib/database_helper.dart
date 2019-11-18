import 'package:flutter/services.dart';
import 'package:silver_dawn/bookings.dart';
import 'package:silver_dawn/destinations.dart';
import 'trips.dart';
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
  String tripTable = 'trip';
  String destinationTable = 'destination';

  String customerID = 'customer_id';
  String firstName = 'first_name';
  String lastName = 'last_name';
  String address = 'address';
  String postCode = 'post_code';
  String email = 'email';
  String phoneNumber = 'phone_number';
  String requirements = 'requirements';

  String tripID = 'trip_id';
  String destinationForeign = 'destination_id';
  String driverForeign = 'driver_id';
  String date = 'date';
  String duration = 'duration';
  String cost = 'cost';

  String destinationID = 'destination_id';
  String name = 'name';
  String hotel = 'hotel';

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

  //-----------------------------Customer Queries-----------------------------//

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
    var result = await db.update(customerTable, customer.toMap(),
        where: '$customerID = ?', whereArgs: [customer.customerID]);
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

  //-----------------------------Trip Queries-----------------------------//

  Future<List<Map<String, dynamic>>> getTripMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT trip.trip_id, destination.name,'
        ' driver.driver_id, coach.coach_id, trip.date, trip.duration, trip.cost'
        ' FROM trip JOIN destination ON trip.destination_id = destination.destination_id'
        ' JOIN driver ON trip.driver_id = driver.driver_id JOIN coach'
        ' ON trip.coach_id = coach.coach_id;');

    return result;
  }

  Future<int> insertTrip(Trips trip) async {
    Database db = await this.database;
    var result = await db.insert(tripTable, trip.toMap());

    return result;
  }

  Future<int> updateTrip(Trips trip) async {
    var db = await this.database;
    var result = await db.update(tripTable, trip.toMap(),
        where: '$tripID = ?', whereArgs: [trip.tripID]);
    return result;
  }

  Future<int> deleteTrip(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tripTable WHERE $tripID = $id');
    return result;
  }

  Future<int> getTripCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $tripID');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //--------------------------------------//

  //-----------------------------Destination Queries-----------------------------//

  Future<List<Map<String, dynamic>>> getDestinationMapList() async {
    Database db = await this.database;
    var result = await db.query(destinationTable, orderBy: '$name ASC');
    return result;
  }

  Future<int> insertDestination(Destinations destination) async {
    Database db = await this.database;
    var result = await db.insert(destinationTable, destination.toMap());

    return result;
  }

  Future<int> updateDestination(Destinations destination) async {
    var db = await this.database;
    var result = await db.update(destinationTable, destination.toMap(),
        where: '$destinationID = ?', whereArgs: [destination.destinationID]);
    return result;
  }

  Future<int> deleteDestination(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $destinationTable WHERE $destinationID = $id');
    return result;
  }

  Future<int> getDestinationCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $destinationID');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //--------------------------------------//

  Future<List<Destinations>> getDestinationList() async{
    var destinationMapList = await getDestinationMapList();
    int count = destinationMapList.length;

    List<Destinations> destinationList = List<Destinations>();
    for (int i = 0; i < count; i++) {
      destinationList.add(Destinations.fromMapObject(destinationMapList[i]));
    }

    return destinationList;
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

  Future<List<Trips>> getTripList() async {

    var tripMapList = await getTripMapList();
    int count = tripMapList.length;

    List<Trips> tripList = List<Trips>();
    for (int i = 0; i < count; i++){
      tripList.add(Trips.fromMapObject(tripMapList[i]));
    }

    return tripList;
  }



}