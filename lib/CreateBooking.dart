import 'dart:async';
import 'package:flutter/material.dart';
import 'package:silver_dawn/bookings.dart';
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
  List<Trips> tripList;

  int customerCount = 0;
  int tripCount = 0;

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
      tripList = List<Trips>();
      updateTripList();
    }

    return WillPopScope(

        onWillPop:() {
          moveToLastScreen();
        },

        child: Scaffold(
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
                      flex: 2,
                      child: Container(
                        child: Card(
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              print('Card tapped.');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: getTripListView(),
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
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height,
                                      child: getCustomerListView(),
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
                                      height: MediaQuery.of(context).size.height,
                                      child: Text("")
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
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                                        child: TextField(
                                          decoration: new InputDecoration(
                                              prefixIcon: Icon(Icons.credit_card),
                                              labelText: "Total Cost",
                                              fillColor: Colors.white,
                                              filled: true
                                          ),
                                          //controller: controller,
                                        ),
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
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                                        child: TextField(
                                          decoration: new InputDecoration(
                                              prefixIcon: Icon(Icons.calendar_today),
                                              labelText: "Trip Duration (Days)",
                                              fillColor: Colors.white,
                                              filled: true
                                          ),
                                          //controller: controller,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
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
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(this.customerList[position].firstName,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.customerList[position].lastName,
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
              debugPrint("ListTile Tapped");
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
        return Card(

          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(this.tripList[position].destinationID.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.tripList[position].coachID.toString(),
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
      Future<List<Trips>> tripListFuture = databaseHelper.getTripList();
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