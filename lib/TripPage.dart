import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:silver_dawn/trip_lookup.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'trips.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:silver_dawn/ViewTrip.dart';
import 'package:money/money.dart';
import 'database_helper.dart';
import 'package:silver_dawn/CreateTrip.dart';

class TripPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TripPageState();
  }
}

class TripPageState extends State<TripPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<TripLookup> tripList;
  List<TripLookup> filteredList = [];
  int count = 0;

  TextEditingController destinationController = new TextEditingController();
  TextEditingController controller = new TextEditingController();
  TextEditingController costController = new TextEditingController();

  String filter;
  String costFilter;

  @override
  initState() {
    
    costController.addListener((){
      setState(() {
        costFilter = costController.text;
        filter = destinationController.text;

        print(costFilter);

        if(costFilter == null || costFilter == ""){
          costFilter = "";
        }

        if(costFilter != null && costFilter != ""){
          listFiltering(filter, "");
        } else{
          resetList();
        }
        
      });
    });

    destinationController.addListener(() {
      setState(() {
        costFilter = costController.text;
        filter = destinationController.text;

        if(costFilter == null || costFilter == ""){
          costFilter = "";
        }

        if(filter != null && filter != ""){
          listFiltering(filter, "");
        } else{
          resetList();
        }

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = 320;
    final double itemWidth = size.width / 2;

    if (tripList == null) {
      tripList = List<TripLookup>();
      updateListView();
    }

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      backgroundColor: Color.fromRGBO(55, 57, 96, 1),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 10.0),
                  child: TextField(
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        labelText: "Destination",
                        fillColor: Colors.white,
                        filled: true
                    ),
                    controller: destinationController,
                  ),
                ),
              ),Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
                  child: TextField(
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.directions_bus),
                        labelText: "Coach Registration",
                        fillColor: Colors.white,
                        filled: true
                    ),
                    controller: costController,
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.only(bottom: 90.0, left: 10.0, right: 10.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 3.0,
                childAspectRatio: (itemWidth / itemHeight - 0.65),
                scrollDirection: Axis.vertical,
                children: List.generate(filteredList.length, (index) {
                  return new GridTile(
                    child: GestureDetector(
                      onTap: (){
                        openTrip(this.filteredList[index], 'Edit Trip');
                        },
                      child: new Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Card(
                              elevation: 4,
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAlias,
                              color: Color.fromRGBO(255, 0, 255, 0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 70
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                            this.filteredList[index].destinationName.toString(),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 25, color: Color.fromRGBO(255, 255, 255, 1))
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
                                    Card(
                                      color: Color.fromRGBO(255, 70, 76, 1),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:2.0, left: 2.0, right: 2.0),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(bottom:2.0),
                                              child: Icon(
                                                  Icons.date_range,
                                                  color: Colors.white,
                                                  size: 40
                                              ),
                                            ), Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right:8.0, bottom: 8.0, top: 4.0),
                                              child: Text(
                                                "Trip Date: ",
                                                style: new TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 52,
                                      child: Card(
                                        color: Color.fromRGBO(55, 57, 96, 1),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                                            child: Text(
                                                this.filteredList[index].date.toString(),
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 23,color: Colors.white)
                                            ),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )

                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 3.0, left: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Card(
                                      color: Color.fromRGBO(255, 70, 76, 1),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                                Icons.credit_card,
                                                color: Colors.white,
                                                size: 40
                                            ), Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right:8.0, bottom: 2.0),
                                              child: Text(
                                                "Ticket Cost: ",
                                                style: new TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 52,
                                      child: Card(
                                        color: Color.fromRGBO(55, 57, 96, 1),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0, left: 10.0),
                                            child: Text(
                                                "£" + format(double.parse(this.filteredList[index].cost.toString())),

                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 23,color: Colors.white)
                                            ),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )

                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                  padding: EdgeInsets.only(top: 20.0, left: 24.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                            Icons.access_time,
                                            color: Colors.blueAccent,
                                            size: 40
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: tripDays(this.filteredList[index].duration),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left:30.0),
                                          child: Card(
                                            elevation: 0,
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                    Icons.directions_bus,
                                                    color: Colors.blueAccent,
                                                    size: 40
                                                ), Padding(
                                                  padding: const EdgeInsets.only(left:8.0, right:8.0),
                                                  child: Text(
                                                    this.filteredList[index].coachRegistration.toString(),
                                                    style: new TextStyle(
                                                      fontSize: 20
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewTrip(Trips(0, 0, 0, '', 0, 0), 'Add Trip' )),
            );
          },
          tooltip: 'Add Customer',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  String format(double n) {
    return n.toStringAsFixed(double.parse(n.toInt().toString() + "0").truncateToDouble() == n ? 0 : 2);
  }

  Widget tripDays(int dayAmount){
    if (dayAmount == 1){
      return Text(
          dayAmount.toInt().toString() + " Day",
        style: new TextStyle(
          color: Colors.black,
          fontSize: 20
        ),
      );
    } else if(dayAmount > 1){
      return Text(
          dayAmount.toInt().toString() + " Days",
        style: new TextStyle(
            color: Colors.black,
            fontSize: 20
        ),
      );
    }
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void _delete(BuildContext context, Trips trip) async {
    int result = await databaseHelper.deleteCustomer(trip.tripID);
    if (result != 0) {
      _showSnackBar(context, 'Customer Deleted Successfully');
      updateListView();
    }
  }

  void listFiltering(firstNameFilter, postFilter){

    DateFormat format = new DateFormat("dd/MM/yyyy");
    print(costFilter);

    this.filteredList = filteredList.where((i) => i.destinationName.toLowerCase()
        .contains(filter.toLowerCase())).where((i) => i.coachRegistration.contains(
        costFilter.toString())).toList();

    this.filteredList.sort((a, b) => format.parse(a.date.substring(0, a.date.length -2 )
        + "20" + a.date.substring(a.date.length - 2))
        .difference(DateTime.now()).compareTo(format.parse(b.date.substring(0, b.date.length -2 )
        + "20" + b.date.substring(b.date.length - 2))
        .difference(DateTime.now())));

  }

  void resetList(){
    this.filteredList = tripList;
  }

  void openTrip(TripLookup trip, String title) async {

    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ViewTrip(trip);
    }));

  }

  void updateListView() {
    final Future<Database> dataInstance = databaseHelper.initializeDatabase();
    dataInstance.then((database) {
      Future<List<TripLookup>> customerListFuture = databaseHelper.getTripLookup();
      customerListFuture.then((tripList) {
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

          this.count = tripList.length;

        });
      });
    });
  }


  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }


}