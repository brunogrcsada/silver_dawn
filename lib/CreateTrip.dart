import 'dart:async';
import 'package:flutter/material.dart';
import 'package:silver_dawn/coaches.dart';
import 'trips.dart';
import 'destinations.dart';
import 'drivers.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sqflite/sqflite.dart';

class NewTrip extends StatefulWidget {

  final String appBarTitle;
  final Trips customer;

  NewTrip(this.customer, this.appBarTitle);

  @override
  _NewTripState createState() => new _NewTripState(appBarTitle, customer);

}

class _NewTripState extends State<NewTrip> {

  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Destinations> destinationList;
  List<Coaches> coachList;
  List<Drivers> driverList;

  var totalCostController = new TextEditingController();
  var tripDurationController = new TextEditingController();

  int count = 0;
  int driverCount = 0;
  int coachCount = 0;

  DateTime currentDate;

  int currentDestination;
  int currentDriver;
  int currentCoach;

  String appBarTitle;
  Trips trip;

  var textEditingControllers = <TextEditingController>[];

  _NewTripState(this.appBarTitle, this.trip);

  @override
  Widget build(BuildContext context) {

    if (destinationList == null) {
      destinationList = List<Destinations>();
      updateListView();
    }

    if (coachList == null) {
      coachList = List<Coaches>();
      updateCoachListView();
    }

    if (driverList == null) {
      driverList = List<Drivers>();
      updateDriverListView();
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
                              child: getTodoListView(),
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
                                      child: getCoachListView(),
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
                                      child: getDriverListView(),
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
                                            padding: EdgeInsets.only(top: 20.0, bottom: 0.0, left: 10.0, right: 10.0),
                                            child: TextField(
                                              controller: totalCostController,
                                              style: new TextStyle(
                                                  fontSize: MediaQuery.of(context).size.height * 0.05,
                                                  color: Colors.black
                                              ),
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(Icons.add_circle),
                                                  labelText: "Total Cost",
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(5.0)
                                                  )
                                              ),
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
                                          controller: tripDurationController,
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
                                                  currentDate = date;
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
                            ), Expanded(
                              flex: 1,
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
                                            _save();

                                            },
                                          child: Text(
                                            'Create Trip',
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

  ListView getTodoListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {

        var selectedColor = const Color.fromRGBO(255, 255, 255, 1);

        if(currentDestination == position){
          selectedColor = Colors.amber;
        }

        return Container(
          child: Card(
            color: selectedColor,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text(this.destinationList[position].name,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              title: Text(this.destinationList[position].name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.delete,color: Colors.red,),

                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  currentDestination = position;
                });
              },
            ),
          ),
        );
      },
    );
  }

  ListView getCoachListView() {
    return ListView.builder(
      itemCount: coachCount,
      itemBuilder: (BuildContext context, int position) {

        var selectedColor = const Color.fromRGBO(255, 255, 255, 1);

        if(currentCoach == position){
          selectedColor = Colors.amber;
        }

        return Card(

          color: selectedColor,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(this.coachList[position].registration,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.coachList[position].seats.toString(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.delete,color: Colors.red,)
                ),
              ],
            ),
            onTap: () {
              setState(() {
                currentCoach = position;
              });
            },
          ),
        );
      },
    );
  }

  ListView getDriverListView() {
    return ListView.builder(
      itemCount: driverCount,
      itemBuilder: (BuildContext context, int position) {

        var selectedColor = const Color.fromRGBO(255, 255, 255, 1);

        if(currentDriver == position){
          selectedColor = Colors.amber;
        }

        return Card(
          color: selectedColor,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(this.driverList[position].firstName,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.driverList[position].lastName,
                style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.delete,color: Colors.red,)
                ),
              ],
            ),
            onTap: () {
              setState(() {
                currentDriver = position;
              });
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

    trip.destinationID = currentDestination;
    trip.coachID = currentCoach;
    trip.driverID = currentDriver;
    trip.cost = double.parse(totalCostController.text);
    trip.duration = double.parse(tripDurationController.text);

    String formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);
    trip.date = formattedDate;

    moveToLastScreen();

    int result;
    if (trip.tripID != null) {  // Case 1: Update operation
      result = await databaseHelper.updateTrip(trip);
    } else { // Case 2: Insert Operation
      result = await databaseHelper.insertTrip(trip);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Trip Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Trip');
    }

  }


  /*
  void _delete() async {

    moveToLastScreen();

    if (customer.customerID == null) {
      _showAlertDialog('Status', 'No Customer was deleted');
      return;
    }

    int result = await helper.deleteCustomer(customer.customerID);
    if (result != 0) {
      _showAlertDialog('Status', 'Customer Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Customer');
    }
  }
  */

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Destinations>> destinationListFuture = databaseHelper.getDestinationList();
      destinationListFuture.then((destinationList) {
        setState(() {
          this.destinationList = destinationList;

          this.count = destinationList.length;
        });
      });
    });
  }

  void updateDriverListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Drivers>> driverListFuture = databaseHelper.getDriverList();
      driverListFuture.then((driverList) {
        setState(() {

          this.driverList = driverList;
          this.driverCount = driverList.length;

        });
      });
    });
  }

  void updateCoachListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Coaches>> coachListFuture = databaseHelper.getCoachList();
      coachListFuture.then((coachList) {
        setState(() {

          this.coachList = coachList;
          this.coachCount = coachList.length;

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