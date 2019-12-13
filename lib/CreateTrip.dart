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

  String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  int currentDestination;
  int currentDriver;
  int currentCoach;

  int currentDestinationID;
  int currentDriverID;
  int currentCoachID;

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
                                      child: Container(
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(left: 16.0),
                                              child: Text(
                                                "Choose a Destination",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                                              ),
                                            ),Padding(
                                              padding: const EdgeInsets.only(left: 13.0),
                                              child: Container(
                                                child: FlatButton(
                                                    color: Colors.red,
                                                    textColor: Colors.white,
                                                    disabledColor: Colors.grey,
                                                    disabledTextColor: Colors.black,
                                                    padding: EdgeInsets.all(8.0),
                                                    splashColor: Colors.blueAccent,

                                                    onPressed: () {
                                                      _inputQuery(context);

                                                    },
                                                      child: Text(
                                                        'New Destination',
                                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: getTodoListView(),
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
                                                  "Choose a Coach",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: getCoachListView(),
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

                                child: Padding(
                                  padding: const EdgeInsets.only(bottom:8.0, left:8.0, right: 8.0),
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
                                                  "Choose a Driver",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: getDriverListView(),
                                            ),
                                          ),
                                        ],
                                      ),
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
                                  controller: totalCostController,
                                  //controller: key.currentState.textEditingControllers[controllerValue],
                                  style: new TextStyle(
                                      fontSize: 25,
                                      color: Colors.white
                                  ),
                                  decoration: InputDecoration(
                                      labelStyle: new TextStyle(color: Colors.white),
                                      prefixIcon: Icon(Icons.supervised_user_circle, color: Colors.white,),

                                      labelText: "Total Cost (£)",
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
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.0, bottom: 0.0, left: 10.0, right: 10.0),
                                child: TextField(
                                  controller: tripDurationController,
                                  //controller: key.currentState.textEditingControllers[controllerValue],
                                  style: new TextStyle(
                                      fontSize: 25,
                                      color: Colors.white
                                  ),
                                  decoration: InputDecoration(

                                      labelStyle: new TextStyle(color: Colors.white),
                                      prefixIcon: Icon(Icons.supervised_user_circle, color: Colors.white,),
                                      labelText: "Trip Duration (Days)",
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
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
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
                                            splashColor: Colors.blueAccent,

                                            onPressed: () {
                                              DatePicker.showDatePicker(context,
                                                  showTitleActions: true,
                                                  minTime: DateTime.now(),
                                                  onChanged: (date) {
                                                  }, onConfirm: (date) {
                                                      setState(() {
                                                        currentDate = DateFormat('dd/MM/yyyy').format(date);
                                                      });
                                                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                                            },
                                            child: Text(
                                              currentDate.toString(),
                                              style: TextStyle(color: Colors.white, fontSize: 30),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ), Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom:8.0, left:8.0, right:6.0),
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
                backgroundColor: Colors.red,
                child: Text((position + 1).toString(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              title: Text(this.destinationList[position].name,
                  style: TextStyle(fontWeight: FontWeight.bold)),

              onTap: () {
                setState(() {
                  currentDestination = position;
                  currentDestinationID = this.destinationList[position].destinationID;
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
              backgroundColor: Colors.red,
              child: Text(this.coachList[position].coachID.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.coachList[position].registration,
                style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                    child: Container(
                      width: 100,
                      height: MediaQuery.of(context).size.height,
                      child: Card(
                        color: Color.fromRGBO(20, 25, 40, 1),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 10.0, bottom: 8.0),
                          child: Text(
                            this.coachList[position].seats.toString() + " Seats",
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
                currentCoach = position;
                currentCoachID = this.coachList[position].coachID;
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
              backgroundColor: Colors.red,
              child: Text(this.driverList[position].driverID.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.driverList[position].firstName + " " +
                this.driverList[position].lastName,
                style: TextStyle(fontWeight: FontWeight.bold)),

            onTap: () {
              setState(() {
                currentDriver = position;
                currentDriverID = this.driverList[position].driverID;
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

      if(currentDestination == null){
        _showDialog('Error', 'Please select a destination.');
      } else if(currentCoach == null){
        _showDialog('Error', 'Please select a coach.');
      } else if(currentDriver == null) {
        _showDialog('Error', 'Please select a driver.');
      } else if(totalCostController.text == null){
        _showDialog('Error', 'Please enter the trip cost');
      } else if(tripDurationController.text == null){
        _showDialog('Error', 'Please enter the duration of the trip');
      } else{

          if (!isNumeric(totalCostController.text.toString())){
            _showDialog('Error', 'Please enter a valid number for the trip cost.');
          } else if (double.parse(totalCostController.text.toString()) < 1){
            _showDialog('Error', 'Please enter a valid cost for the trip.');
          } else if (double.parse(totalCostController.text.toString()) > 1000){
            _showDialog('Error', 'Please enter a trip cost lower than £1000.');
          } else if(!isNumeric(tripDurationController.text.toString())){
            _showDialog('Error', 'Please enter a valid number for the trip duration.');
          } else if (int.parse(tripDurationController.text.toString()) < 1){
            _showDialog('Error', 'Please enter a positive value for the trip duration.');
          } else {

            trip.destinationID = currentDestinationID;
            trip.coachID = currentCoachID;
            trip.driverID = currentDriverID;

            trip.cost = double.parse(totalCostController.text); // TODO: Fix pricing difference
            trip.duration = int.parse(tripDurationController.text.toString());  // TODO: Ensure that user enters a valid duration


            trip.date = currentDate.substring(0, currentDate.length -4 )
                + currentDate.substring(currentDate.length - 2);

            moveToLastScreen();

            int result;
            if (trip.tripID != null) {
              result = await databaseHelper.updateTrip(trip);
            } else {
              result = await databaseHelper.insertTrip(trip);
            }

            if (result != 0) { // Success
              _showAlertDialog('Status', 'Trip Saved Successfully');
            } else { // Failure
              _showAlertDialog('Status', 'Problem Saving Trip');
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

  Future<String> _inputQuery(BuildContext context) async {
    String destinationName = '';
    String destinationHotel = '';
    return showDialog<String>(
      context: context,
      barrierDismissible: true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Destination Details'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Name', hintText: 'eg. Edinburgh Hogmanay.'),
                    onChanged: (value) {
                      destinationName = value;
                    },
                  )),
              new Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left:9.0),
                    child: new TextField(
                      autofocus: true,
                      decoration: new InputDecoration(
                          labelText: 'Hotel', hintText: 'eg. Grosvenor.'),
                      onChanged: (value) {
                        destinationHotel = value;
                      },
                    ),
                  ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                databaseHelper.insertDestination(Destinations(destinationName, destinationHotel));
                updateListView();
                Navigator.of(context).pop();
              },
            ),
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