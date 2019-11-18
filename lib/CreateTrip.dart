import 'dart:async';
import 'package:flutter/material.dart';
import 'trips.dart';
import 'destinations.dart';
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
  int count = 0;

  String appBarTitle;
  Trips customer;

  var textEditingControllers = <TextEditingController>[];


  _NewTripState(this.appBarTitle, this.customer);

  @override
  Widget build(BuildContext context) {

    customer.variableList.forEach((str) {
      var textEditingController = new TextEditingController(text: str);
      textEditingControllers.add(textEditingController);
    });

    if (destinationList == null) {
      destinationList = List<Destinations>();
      updateListView();
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
                                    onTap: () {
                                      print('Card tapped.');
                                    },
                                    child: Container(
                                      child: Text('A card that can be tapped'),
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
                                      child: Text('A card that can be tapped'),
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
                                      child: Text('A card that can be tapped'),
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
                                      child: Text('A card that can be tapped'),
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

  ListView getTodoListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
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


  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Save data to database
  /*
  void _save() async {

    customer.firstName = textEditingControllers[0].text;
    customer.lastName = textEditingControllers[1].text;
    customer.address = textEditingControllers[2].text;
    customer.address2 = textEditingControllers[3].text;
    customer.town = textEditingControllers[4].text;
    customer.postCode = textEditingControllers[5].text;
    customer.phoneNumber = textEditingControllers[6].text;
    customer.email = textEditingControllers[7].text;
    customer.requirements = textEditingControllers[8].text;

    moveToLastScreen();

    int result;
    if (customer.customerID != null) {  // Case 1: Update operation
      result = await helper.updateCustomer(customer);
    } else { // Case 2: Insert Operation
      result = await helper.insertCustomer(customer);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Customer Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Customer');
    }

  }
   */

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