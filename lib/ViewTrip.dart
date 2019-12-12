import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:silver_dawn/booking_lookup.dart';
import 'package:silver_dawn/bookings.dart';
import 'package:silver_dawn/trip_lookup.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'trips.dart';
import 'package:date_format/date_format.dart';
import 'database_helper.dart';


class ViewTrip extends StatefulWidget {

  final TripLookup trip;

  ViewTrip(this.trip);

  @override
  _ViewTripState createState() => new _ViewTripState(trip);
}

class _ViewTripState extends State<ViewTrip>{
  DatabaseHelper databaseHelper = DatabaseHelper();

  TripLookup trip;

  List<BookingLookup> bookingList;
  List<BookingLookup> filteredList;

  int bookingCount = 0;
  int totalCustomers = 0;

  _ViewTripState(this.trip);


  @override
  Widget build(BuildContext context) {
    if (bookingList == null) {
      updateBookingListView();
    }
    // TODO: implement build
    return WillPopScope(

        onWillPop:() {
          moveToLastScreen();
        },

        child: Scaffold(
          backgroundColor: Color.fromRGBO(55, 57, 96, 1),
          appBar: AppBar(
            title: Text(this.trip.destinationName.toString()),
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
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Container(

                                child: Padding(
                                  padding: const EdgeInsets.only(top:8.0, bottom: 8.0, left:8.0),
                                  child: Card(
                                    color: Color.fromRGBO(255,70,76,1),
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
                                                  "Trip Information",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        child: Card(
                                                          child: Container(
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  width: 130,
                                                                  height: MediaQuery.of(context).size.height,
                                                                  child: Card(
                                                                    color: Color.fromRGBO(55, 57, 96, 1),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(15.0),
                                                                      child: Text(
                                                                        "Name:",
                                                                        style: new TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 30
                                                                        ),
                                                                      ),
                                                                    ),

                                                                  ),
                                                                ), Padding(
                                                                  padding: const EdgeInsets.all(20.0),
                                                                  child: Text(
                                                                    this.trip.destinationName,
                                                                    style: new TextStyle(
                                                                      fontSize: 30,
                                                                    ),
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
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width,
                                                              child: Card(
                                                                child: Container(
                                                                  child: Row(
                                                                    children: <Widget>[
                                                                      Container(
                                                                        width: 130,
                                                                        height: MediaQuery.of(context).size.height,
                                                                        child: Card(
                                                                          color: Color.fromRGBO(55, 57, 96, 1),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(15.0),
                                                                            child: Text(
                                                                              "Coach:",
                                                                              style: new TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 28
                                                                              ),
                                                                            ),
                                                                          ),

                                                                        ),
                                                                      ), Padding(
                                                                        padding: const EdgeInsets.all(20.0),
                                                                        child: Text(
                                                                          this.trip.coachRegistration.toString(),
                                                                          style: new TextStyle(
                                                                            fontSize: 26,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ), Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width,
                                                              child: Card(
                                                                child: Container(
                                                                  child: Row(
                                                                    children: <Widget>[
                                                                      Container(
                                                                        width: 125,
                                                                        height: MediaQuery.of(context).size.height,
                                                                        child: Card(
                                                                          color: Color.fromRGBO(55, 57, 96, 1),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(15.0),
                                                                            child: Text(
                                                                              "Driver:",
                                                                              style: new TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 30
                                                                              ),
                                                                            ),
                                                                          ),

                                                                        ),
                                                                      ), Padding(
                                                                        padding: const EdgeInsets.all(20.0),
                                                                        child: Text(
                                                                          this.trip.driverFirstName.toString(),
                                                                          style: new TextStyle(
                                                                            fontSize: 30,
                                                                          ),
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
                                                  ), Expanded(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width,
                                                            child: Card(
                                                              child: Container(
                                                                child: Row(
                                                                  children: <Widget>[
                                                                    Container(
                                                                      width: 115,
                                                                      height: MediaQuery.of(context).size.height,
                                                                      child: Card(
                                                                        color: Color.fromRGBO(55, 57, 96, 1),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(15.0),
                                                                          child: Text(
                                                                            "Days:",
                                                                            style: new TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 30
                                                                            ),
                                                                          ),
                                                                        ),

                                                                      ),
                                                                    ), Padding(
                                                                      padding: const EdgeInsets.all(20.0),
                                                                      child: Text(
                                                                        this.trip.duration.toInt().toString(),
                                                                        style: new TextStyle(
                                                                          fontSize: 30,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                       ), Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width,
                                                              child: Card(
                                                                child: Container(
                                                                  child: Row(
                                                                    children: <Widget>[
                                                                      Container(
                                                                        width: 115,
                                                                        height: MediaQuery.of(context).size.height,
                                                                        child: Card(
                                                                          color: Color.fromRGBO(55, 57, 96, 1),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(15.0),
                                                                            child: Text(
                                                                              "Cost:",
                                                                              style: new TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 30
                                                                              ),
                                                                            ),
                                                                          ),

                                                                        ),
                                                                      ), Padding(
                                                                        padding: const EdgeInsets.all(20.0),
                                                                        child: Text(
                                                                          "£" + this.trip.cost.toString() + "0",
                                                                          style: new TextStyle(
                                                                            fontSize: 30,
                                                                          ),
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
                                                  ),Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left:8.0, bottom:8.0, top:8.0),
                                                            child: Container(
                                                              height: MediaQuery.of(context).size.height,
                                                              child: Card(
                                                                color: Color.fromRGBO(55, 57, 96, 1),
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top:20.0),
                                                                      child: Icon(
                                                                        Icons.date_range,
                                                                        size: 70,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top:14.0),
                                                                      child: Text(
                                                                        this.trip.date,
                                                                        textAlign: TextAlign.center,
                                                                        style: new TextStyle(
                                                                          fontSize: 40,
                                                                          color: Colors.white
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )

                                                              ),
                                                            ),
                                                          ),
                                                        ),Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              height: MediaQuery.of(context).size.height,
                                                              child: Card(
                                                                color:  Color.fromRGBO(55, 57, 96, 1),
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top:20.0),
                                                                      child: Icon(
                                                                        Icons.credit_card,
                                                                        color: Colors.white,
                                                                        size: 70,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(12.0),
                                                                      child: Text(
                                                                          "£" + (this.trip.cost * totalCustomers).toString() + "0",
                                                                        style: new TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 40
                                                                        ),
                                                                        textAlign: TextAlign.center,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                                          "Customer List",
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
                    )
                  ],
                ),
              ),

            ],
          ),

        ));


  }

  ListView getCustomerListView() {
    return ListView.builder(
      itemCount: bookingCount,
      itemBuilder: (BuildContext context, int position) {

        return Card(
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text((position + 1).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.filteredList[position].firstName.toString() + " " + this.filteredList[position].lastName.toString(),
                style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Card(
                      color: Color.fromRGBO(17, 18, 33, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Icon(
                                Icons.supervised_user_circle,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0, right: 10.0),
                              child: Text(
                                this.filteredList[position].passengers.toString(),
                                style: new TextStyle(
                                  fontSize: 20,
                                  color: Colors.white
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    //_delete(context, customerList[position]);
                  },
                ),
              ],
            ),
            onTap: () {

              _customerQuery(context, this.filteredList[position].firstName.toString(),
                  this.filteredList[position].lastName.toString(), this.filteredList[position].phoneNumber.toString(),
                  this.filteredList[position].email.toString(), this.filteredList[position].postCode.toString(),
                  this.filteredList[position].address.toString(), this.filteredList[position].address2.toString(),
                  this.filteredList[position].town.toString(), this.filteredList[position].requirements.toString());
            },
          ),
        );
      },
    );
  }

  void updateBookingListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<BookingLookup>> bookingListFuture = databaseHelper.getFilteredBooking();
      bookingListFuture.then((bookingList) {
        setState(() {

          filteredList = bookingList.where((i) => i.tripID == this.trip.tripID).toList();
          this.bookingList = filteredList;
          this.bookingCount = filteredList.length;

          for(var i = 0; i < bookingCount; i++){
            totalCustomers += filteredList[i].passengers;
          }

        });
      });
    });
  }

  Future<String> _customerQuery(BuildContext context, String firstName,
      String lastName, String phoneNumber, String email, String postCode,
      String address1, String address2, String city, String requirements) async {

    return showDialog<String>(
      context: context,
      barrierDismissible: true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width * 1,
          child: AlertDialog(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0),

            content:  Padding(
              padding: const EdgeInsets.only(bottom: 60.0 ),
              child: new Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left:20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 4,
                        clipBehavior: Clip.antiAlias,
                        color: Color.fromRGBO(255, 0, 0, 0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 10.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                    Icons.person_pin,
                                    color: Colors.white,
                                    size: 70
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                      firstName + " " + lastName,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 30, color: Color.fromRGBO(255, 255, 255, 1))
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                  Icons.phone_in_talk,
                                  color: Colors.blueAccent,
                                  size: 40
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                    phoneNumber, //TODO: Should be phone number, not email.
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 23)
                                ),
                              ),
                            ],
                          )

                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                  Icons.email,
                                  color: Colors.blueAccent,
                                  size: 40
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10.0, left: 10.0),
                                    child: Text(
                                        email, //TODO: Should be phone number, not email.
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 23)
                                    ),

                                  ),
                                ),
                              ),
                            ],
                          )

                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                  Icons.location_on,
                                  color: Colors.blueAccent,
                                  size: 40
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                    postCode, //TODO: Should be phone number, not email.
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 23)
                                ),
                              ),
                            ],
                          )

                      ),Padding(
                          padding: EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                  Icons.my_location,
                                  color: Colors.blueAccent,
                                  size: 40
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                  child: getAddress(address1, address2, city)
                              ),
                            ],
                          )

                      ),Padding(
                          padding: EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                  Icons.assignment_turned_in,
                                  color: Colors.blueAccent,
                                  size: 40
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                 child: getSpecialRequirement(
                                        requirements)
                               ),

                            ],
                          )

                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: FlatButton(
                              child: Text('Close'),
                              color: Colors.blue,
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.all(8.0),
                              splashColor: Colors.blueAccent,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],

                  ),
                ),
              ),
            ),

          ),
        );
      },
    );
  }

  Widget getSpecialRequirement(String specialRequirement){
    if(specialRequirement == "null"){
      return Text(
          "Not Required",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 23)
      );
    } else{
      return Text(
          specialRequirement,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 23)
      );
    }
  }

  Widget getAddress(String address1, String address2, String town){
    if(address2 == "null"){
      return Text(
          address1 + ", " + town,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 23)
      );
    } else{
      return Text(
          address1 + ", " + address2 + ", " + town,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 23)
      );
    }

  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}
