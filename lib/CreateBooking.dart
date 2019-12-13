import 'dart:async';
import 'package:flutter/material.dart';
import 'package:silver_dawn/bookings.dart';
import 'package:silver_dawn/cutomer_lookup.dart';
import 'package:silver_dawn/trip_lookup.dart';
import 'package:intl/intl.dart';
import 'customers.dart';
import 'database_helper.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sqflite/sqflite.dart';

class NewBooking extends StatefulWidget {

  final String appBarTitle;
  final Bookings customer;

  NewBooking(this.customer, this.appBarTitle);

  @override
  _NewBookingState createState() => new _NewBookingState(appBarTitle, customer);

}

class _NewBookingState extends State<NewBooking> {

  DatabaseHelper databaseHelper = DatabaseHelper();

  List<CustomerLookup> customerList;
  List<TripLookup> tripList;
  List<TripLookup> filteredList = [];

  var passengerNumber = new TextEditingController();
  var specialRequirements = new TextEditingController();

  DateTime selectedDate = DateTime.now();

  int customerCount = 0;
  int tripCount = 0;

  int currentTrip;
  int currentTripID;

  int currentCustomer;
  int currentCustomerID;

  String appBarTitle;
  Bookings bookings;

  var textEditingControllers = <TextEditingController>[];

  _NewBookingState(this.appBarTitle, this.bookings);

  @override
  Widget build(BuildContext context) {

    if (customerList == null) {
      customerList = List<CustomerLookup>();
      updateCustomerList();
    }

    if (tripList == null) {
      tripList = List<TripLookup>();
      updateTripList();
    }

    return WillPopScope(

        onWillPop:() {
          moveToLastScreen();
        },

        child: Scaffold(
          backgroundColor: Color.fromRGBO(55, 57, 96, 1),
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(icon: Icon(
                Icons.arrow_back),
                onPressed: () {
                  moveToLastScreen();
                }
            ),
          ),

          body: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Container(

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(

                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  print('Card tapped.');
                                },
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 60,
                                      child: Card(
                                        margin: EdgeInsets.zero,
                                        clipBehavior: Clip.antiAlias,
                                        color: Color.fromRGBO(17, 18, 33, 1),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            "Choose a Customer",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: getCustomerListView(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ),
                          ),
                      ),
                    ),Expanded(

                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Container(

                                child: Padding(
                                  padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
                                  child: Card(

                                    child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      onTap: () {
                                        print('Card tapped.');
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 60,
                                            child: Card(
                                              margin: EdgeInsets.zero,
                                              clipBehavior: Clip.antiAlias,
                                              color: Color.fromRGBO(17, 18, 33, 1),
                                              child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Text(
                                                  "Choose a Trip",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: getTripListView(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20.0, bottom: 0.0, left: 10.0, right: 10.0),
                                  child: TextField(
                                    controller: passengerNumber,
                                    //controller: key.currentState.textEditingControllers[controllerValue],
                                    style: new TextStyle(
                                        fontSize: MediaQuery.of(context).size.height * 0.05,
                                        color: Colors.white
                                    ),
                                    decoration: InputDecoration(

                                        labelStyle: new TextStyle(color: Colors.white),
                                        prefixIcon: Icon(Icons.supervised_user_circle, color: Colors.white,),
                                        labelText: "Passengers",
                                        enabledBorder: new OutlineInputBorder(
                                            borderSide: new BorderSide(color: Colors.white)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          borderSide: new BorderSide(
                                            color: Colors.white
                                          )

                                        )
                                    ),
                                  ),
                                ),
                              ),

                            Expanded(
                              flex: 2,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 10.0, right: 10.0),
                                  child: TextField(
                                    controller: specialRequirements,
                                    maxLines: 99,
                                    //controller: key.currentState.textEditingControllers[controllerValue],
                                    style: new TextStyle(
                                        fontSize: MediaQuery.of(context).size.height * 0.05,
                                        color: Colors.white
                                    ),
                                    decoration: InputDecoration(
                                        hintStyle: new TextStyle(color: Colors.white),
                                        labelStyle: new TextStyle(color: Colors.white),
                                        hintText: "Special Requests",
                                        enabledBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(color: Colors.white)
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0),
                                          borderSide: new BorderSide(
                                            color: Colors.white
                                          )
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom:8.0, left:8.0, right:8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    child: InkWell(
                                      splashColor: Colors.amber.withAlpha(30),
                                      child: Container(
                                        child: FlatButton(
                                            color: Colors.red,
                                            textColor: Colors.white,
                                            disabledColor: Colors.grey,
                                            disabledTextColor: Colors.black,
                                            padding: EdgeInsets.all(8.0),
                                            splashColor: Colors.blueAccent,

                                            onPressed: () {
                                              _save();
                                             // _save();

                                            },
                                            child: Text(
                                              'Create Booking',
                                              style: TextStyle(color: Colors.white, fontSize: 30),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),

        ));


  }

  ListView getCustomerListView() {
    return ListView.builder(
      itemCount: customerCount,
      itemBuilder: (BuildContext context, int position) {

        var selectedColor = const Color.fromRGBO(255, 255, 255, 1);

        if(currentCustomer == position){
          selectedColor = Colors.amber;
        }

        return Card(
          color: selectedColor,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(this.customerList[position].customerID.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.customerList[position].firstName + " " + this.customerList[position].lastName,
                style: TextStyle(fontWeight: FontWeight.bold)),

            onTap: () {
              setState(() {
                currentCustomer = position;
                currentCustomerID = this.customerList[position].customerID;
              });
            },
          ),
        );
      },
    );
  }

  ListView getTripListView() {
    return ListView.builder(
      itemCount: tripCount,
      itemBuilder: (BuildContext context, int position) {

        var selectedColor = const Color.fromRGBO(255, 255, 255, 1);

        if(currentTrip == position){
          selectedColor = Colors.amber;
        }

        return Card(
          color: selectedColor,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text((position + 1).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.tripList[position].destinationName.toString(),
                style: TextStyle(fontWeight: FontWeight.bold)),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                      child: Container(
                        width: 101,
                        height: MediaQuery.of(context).size.height,
                        child: Card(
                          color: Color.fromRGBO(20, 25, 40, 1),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 9.0, bottom: 8.0),
                            child: Text(
                              this.tripList[position].date.toString(),
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                ),
              ],
            ),

            onTap: () {
              setState(() {
                currentTrip = position;
                currentTripID = this.tripList[position].tripID;
              });
              debugPrint("ListTile Tapped");
            },
          ),
        );
      },
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _save() async {

    if(currentCustomerID == null){
      _showDialog('Error', 'Please select a customer.');
    } else if(currentTripID == null){
      _showDialog('Error', 'Please select a trip.');
    } else if(passengerNumber.text == ""){
      _showDialog('Error', 'Please enter a passenger number.');
    } else{

      if(!isNumeric(passengerNumber.text.toString())){
        _showDialog('Error', 'Please enter a number as the passenger amount!');
      } else if(int.parse(passengerNumber.text) < 1){
        _showDialog('Error', 'Please enter a positive number of passengers higher than 1!');
      } else{

        if(specialRequirements.text == ""){
          bookings.requirements = null;
          bookings.customerID = currentCustomerID;
          bookings.tripID = currentTripID;

          String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

          bookings.date = currentDate.substring(0, currentDate.length -4 )
              + currentDate.substring(currentDate.length - 2);
          bookings.passengerNumber = int.parse(passengerNumber.text);

          moveToLastScreen();

          int result;
          if (bookings.bookingID != null) {  // Case 1: Update operation
            result = await databaseHelper.updateBooking(bookings);
          } else { // Case 2: Insert Operation
            result = await databaseHelper.insertBooking(bookings);
          }

          if (result != 0) {  // Success
            _showDialog('Status', 'Booking Saved Successfully');
          } else {  // Failure
            _showDialog('Status', 'Problem Saving Booking');
          }
        } else{
          if(specialRequirements.text.length > 255){
            _showDialog('Error', 'Please enter a shorter note for special requirements!');
          } else{
            bookings.requirements = specialRequirements.text;

            bookings.customerID = currentCustomerID;
            bookings.tripID = currentTripID;

            String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

            bookings.date = currentDate.substring(0, currentDate.length -4 )
                + currentDate.substring(currentDate.length - 2);

            bookings.passengerNumber = int.parse(passengerNumber.text);

            moveToLastScreen();

            int result;
            if (bookings.bookingID != null) {  // Case 1: Update operation
              result = await databaseHelper.updateBooking(bookings);
            } else { // Case 2: Insert Operation
              result = await databaseHelper.insertBooking(bookings);
            }

            if (result != 0) {  // Success
              _showDialog('Status', 'Booking Saved Successfully');
            } else {  // Failure
              _showDialog('Status', 'Problem Saving Booking');
            }
          }

        }


      }


    }

  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  void updateCustomerList() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<CustomerLookup>> customerListFuture = databaseHelper.getFilteredCustomers();
      customerListFuture.then((customerList) {
        setState(() {
          this.customerList = customerList;
          this.customerCount = customerList.length;
        });
      });
    });
  }

  void updateTripList(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TripLookup>> tripListFuture = databaseHelper.getTripLookup();
      tripListFuture.then((tripList) {
        setState(() {

          DateFormat format = new DateFormat("dd/MM/yyyy");

          this.tripList = tripList;
          this.filteredList = tripList.where(
                  (i) => !format.parse(i.date.substring(0, i.date.length -2 )
                  + "20" + i.date.substring(i.date.length - 2))
                  .difference(DateTime.now()).isNegative).toList();

          this.filteredList.sort((a, b) => format.parse(a.date.substring(0, a.date.length -2 )
              + "20" + a.date.substring(a.date.length - 2))
              .difference(DateTime.now()).compareTo(format.parse(b.date.substring(0, b.date.length -2 )
              + "20" + b.date.substring(b.date.length - 2))
              .difference(DateTime.now())));

          this.tripList = filteredList;

          this.tripCount = tripList.length;

        });
      });
    });
  }

  void _showDialog(String title, String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}