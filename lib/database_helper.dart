import 'package:flutter/services.dart';
import 'package:silver_dawn/bookings.dart';
import 'package:silver_dawn/cities.dart';
import 'package:silver_dawn/coaches.dart';
import 'package:silver_dawn/cutomer_lookup.dart';
import 'package:silver_dawn/drivers.dart';
import 'package:silver_dawn/destinations.dart';
import 'trips.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'trip_lookup.dart';
import 'dart:io';
import 'package:silver_dawn/customers.dart';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'booking_lookup.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;
  static Database _database;

  Database customersDatabase;

  String customerTable = 'customer';
  String tripTable = 'trip';
  String destinationTable = 'destination';
  String coachTable = 'coach';
  String driverTable = 'driver';
  String bookingTable = 'booking';
  String cityTable = 'city';

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

  String driverID = 'driver_id';
  String driverFirstName = 'first_name';
  String driverLastName = 'last_name';

  String coachID = 'coach_id';
  String registration = 'registration';
  String seats = 'seats';

  String bookingID = 'booking_id';
  String bookingCustomerID = 'customer_id';
  String bookingTripID = 'booking_id';
  String passengerNumber = 'passenger_number';
  String bookingDate = 'date';
  String bookingRequests = 'requests';

  String cityID = 'city_id';
  String cityName = 'name';

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

  //---------------------------Booking Queries----------------------------//

  Future<List<Map<String, dynamic>>> getBookMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT booking.booking_id, booking.trip_id, customer.first_name,'
        ' customer.last_name, booking.passenger_number '
        ' FROM booking JOIN customer ON booking.customer_id = customer.customer_id;');

    return result;
  }

  Future<List<Map<String, dynamic>>> getCustomerQueryMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT customer.customer_id, customer.first_name,'
        ' customer.last_name, customer.address_1, customer.address_2, city.name,'
        ' customer.post_code, customer.email, customer.phone_number, customer.requirements'
        ' FROM customer JOIN city ON customer.city = city.city_id;');

    return result;
  }

  //-----------------------------Trip Queries-----------------------------//

  Future<List<Map<String, dynamic>>> getTripMapList() async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT trip.trip_id, destination.name,'
        ' driver.first_name, driver.last_name, coach.registration, trip.date, trip.duration, trip.cost'
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

  //--------------------------------------------------------------------------//

  //-------------------------------City Queries-------------------------------//

  Future<List<Map<String, dynamic>>> getCityMapList() async {
    Database db = await this.database;
    var result = await db.query(cityTable);
    return result;
  }

  Future<int> insertCity(Cities city) async {
    Database db = await this.database;
    var result = await db.insert(cityTable, city.toMap());

    return result;
  }

  Future<int> updateCity(Cities city) async {
    var db = await this.database;
    var result = await db.update(cityTable, city.toMap(),
        where: '$cityID = ?', whereArgs: [city.cityID]);
    return result;
  }

  Future<int> deleteCity(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $cityTable WHERE $cityID = $id');
    return result;
  }

  Future<int> getCityCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $cityID');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //-----------------------------Destination Queries--------------------------//

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

  //--------------------------------------------------------------------------//

  //-----------------------------Coach Queries--------------------------------//

  Future<List<Map<String, dynamic>>> getCoachMapList() async {
    Database db = await this.database;
    var result = await db.query(coachTable, orderBy: '$registration ASC');
    return result;
  }

  Future<int> insertCoach(Coaches coach) async {
    Database db = await this.database;
    var result = await db.insert(coachTable, coach.toMap());

    return result;
  }

  Future<int> updateCoach(Coaches coach) async {
    var db = await this.database;
    var result = await db.update(coachTable, coach.toMap(),
        where: '$coachID = ?', whereArgs: [coach.coachID]);
    return result;
  }

  Future<int> deleteCoach(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $coachTable WHERE $coachID = $id');
    return result;
  }

  Future<int> getCoachCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $coachID');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //--------------------------------------//

  //-----------------------------Driver Queries-----------------------------//

  Future<List<Map<String, dynamic>>> getDriverMapList() async {
    Database db = await this.database;
    var result = await db.query(driverTable, orderBy: '$driverFirstName ASC');
    return result;
  }

  Future<int> insertDriver(Drivers driver) async {
    Database db = await this.database;
    var result = await db.insert(driverTable, driver.toMap());

    return result;
  }

  Future<int> updateDriver(Drivers driver) async {
    var db = await this.database;
    var result = await db.update(driverTable, driver.toMap(),
        where: '$driverID = ?', whereArgs: [driver.driverID]);
    return result;
  }

  Future<int> deleteDriver(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $driverTable WHERE $driverID = $id');
    return result;
  }

  Future<int> getDriverCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $driverID');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //--------------------------------------//

  //-----------------------------Booking Queries-----------------------------//

  Future<List<Map<String, dynamic>>> getBookingMapList() async {
    Database db = await this.database;
    var result = await db.query(bookingTable, orderBy: '$bookingDate ASC');
    return result;
  }

  Future<int> insertBooking(Bookings booking) async {
    Database db = await this.database;
    var result = await db.insert(bookingTable, booking.toMap());

    return result;
  }

  Future<int> updateBooking(Bookings booking) async {
    var db = await this.database;
    var result = await db.update(bookingTable, booking.toMap(),
        where: '$bookingID = ?', whereArgs: [booking.bookingID]);
    return result;
  }

  Future<int> deleteBooking(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $bookingTable WHERE $bookingID = $id');
    return result;
  }

  Future<int> getBookingCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $bookingID');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //--------------------------------------//

  Future <List<Drivers>> getDriverList() async{
    var driverMapList = await getDriverMapList();
    int count = driverMapList.length;

    List<Drivers> driverList = List<Drivers>();
    for (int i = 0; i < count; i++){
      driverList.add(Drivers.fromMapObject(driverMapList[i]));
    }

    return driverList;
  }

  Future <List<Bookings>> getBookingList() async{
    var bookingMapList = await getBookingMapList();
    int count = bookingMapList.length;

    List<Bookings> bookingList = List<Bookings>();
    for (int i = 0; i < count; i++){
      bookingList.add(Bookings.fromMapObject(bookingMapList[i]));
    }

    return bookingList;
  }

  Future <List<TripLookup>> getTripLookup() async{
    var tripLookupMapList = await getTripMapList();
    int count = tripLookupMapList.length;

    List<TripLookup> lookupList = List<TripLookup>();
    for (int i = 0; i < count; i++){
      lookupList.add(TripLookup.fromMapObject(tripLookupMapList[i]));
    }

    return lookupList;
  }

  Future <List<Cities>> getCity() async{
    var cityMapList = await getCityMapList();
    int count = cityMapList.length;

    List<Cities> cityList = List<Cities>();
    for (int i = 0; i < count; i++){
      cityList.add(Cities.fromMapObject(cityMapList[i]));
    }

    return cityList;
  }

  Future <List<BookingLookup>> getFilteredBooking() async{
    var bookingLookupMapList = await getBookMapList();
    int count = bookingLookupMapList.length;

    List<BookingLookup> bookingList = List<BookingLookup>();
    for (int i = 0; i < count; i++){
      bookingList.add(BookingLookup.fromMapObject(bookingLookupMapList[i]));
    }

    return bookingList;
  }

  Future <List<CustomerLookup>> getFilteredCustomers() async{
    var customerLookupMapList = await getCustomerQueryMapList();
    int count = customerLookupMapList.length;

    List<CustomerLookup> customerList = List<CustomerLookup>();
    for (int i = 0; i < count; i++){
      customerList.add(CustomerLookup.fromMapObject(customerLookupMapList[i]));
    }

    return customerList;
  }

  Future<List<Coaches>> getCoachList() async{
    var coachMapList = await getCoachMapList();
    int count = coachMapList.length;

    List<Coaches> coachList = List<Coaches>();
    for (int i = 0; i < count; i++){
      coachList.add(Coaches.fromMapObject(coachMapList[i]));
    }

    return coachList;
  }

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