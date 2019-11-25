import 'dart:async';
import 'package:flutter/material.dart';
import 'package:silver_dawn/bookings.dart';
import 'package:silver_dawn/trip_lookup.dart';
import 'trips.dart';
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

  List<Customers> customerList;
  List<TripLookup> tripList;

  int customerCount = 0;
  int tripCount = 0;

  int currentTrip;
  int currentCustomer;

  String appBarTitle;
  Bookings customer;

  var textEditingControllers = <TextEditingController>[];

  _NewBookingState(this.appBarTitle, this.customer);

  @override
  Widget build(BuildContext context) {

    customer.variableList.forEach((str) {
      var textEditingController = new TextEditingController(text: str);
      textEditingControllers.add(textEditingController);
    });

    if (customerList == null) {
      customerList = List<Customers>();
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
                                                  "Choose a Destination",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
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
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      print('Card tapped.');
                                    },
                                    child: Container(
                                      child: FlatButton(
                                          color: Colors.blue,
                                          textColor: Colors.white,
                                          disabledColor: Colors.grey,
                                          disabledTextColor: Colors.black,
                                          padding: EdgeInsets.all(8.0),
                                          splashColor: Colors.blueAccent,

                                          onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime.now(),
                                                onChanged: (date) {
                                                  print('change $date');
                                                }, onConfirm: (date) {
                                                  print('confirm $date');
                                                }, currentTime: DateTime.now(), locale: LocaleType.en);
                                          },
                                          child: Text(
                                            'Select Date',
                                            style: TextStyle(color: Colors.white, fontSize: 30),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                    //controller: key.currentState.textEditingControllers[controllerValue],
                                    style: new TextStyle(
                                        fontSize: MediaQuery.of(context).size.height * 0.05,
                                        color: Colors.black
                                    ),
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.supervised_user_circle),
                                        labelText: "Passengers",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0)
                                        )
                                    ),
                                  ),
                                ),
                              ),

                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20.0, bottom: 0.0, left: 10.0, right: 10.0),
                                  child: TextField(

                                    maxLines: 99,
                                    //controller: key.currentState.textEditingControllers[controllerValue],
                                    style: new TextStyle(
                                        fontSize: MediaQuery.of(context).size.height * 0.05,
                                        color: Colors.black
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Special Requests",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5.0)
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: InkWell(
                                    splashColor: Colors.amber.withAlpha(30),
                                    onTap: (){
                                      print("Create new Trip");
                                    },
                                    child: Container(
                                      child: FlatButton(
                                          color: Colors.red,
                                          textColor: Colors.white,
                                          disabledColor: Colors.grey,
                                          disabledTextColor: Colors.black,
                                          padding: EdgeInsets.all(8.0),
                                          splashColor: Colors.blueAccent,

                                          onPressed: () {
                                            print("Woop");
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
              backgroundColor: Colors.amber,
              child: Text(this.customerList[position].customerID.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.customerList[position].firstName + " " + this.customerList[position].lastName,
                style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.delete,color: Colors.red,),
                  onTap: () {
                    //_delete(context, customerList[position]);
                  },
                ),
              ],
            ),
            onTap: () {
              setState(() {
                currentCustomer = position;
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
              backgroundColor: Colors.amber,
              child: Text((position + 1).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.tripList[position].destinationID.toString(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.delete,color: Colors.red,),
                  onTap: () {
                    setState(() {

                    });
                    //_delete(context, customerList[position]);
                  },
                ),
              ],
            ),
            onTap: () {
              setState(() {
                currentTrip = position;
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

  void updateCustomerList() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Customers>> customerListFuture = databaseHelper.getCustomerList();
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

          this.tripList = tripList;
          this.tripCount = tripList.length;

        });
      });
    });
  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

}