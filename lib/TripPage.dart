import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'trips.dart';
import 'package:date_format/date_format.dart';
import 'database_helper.dart';

class TripPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TripPageState();
  }
}

class TripPageState extends State<TripPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Trips> tripList;
  List<Trips> filteredList = [];
  int count = 0;

  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  initState() {
    final now = DateTime.now();
    concurrentList(now);

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = 320;
    final double itemWidth = size.width / 2;

    if (tripList == null) {
      tripList = List<Trips>();
      updateListView();
    }

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 29, 1),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                  child: TextField(
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.verified_user),
                        labelText: "First Name",
                        fillColor: Colors.white,
                        filled: true
                    ),
                    controller: controller,
                  ),
                ),
              ),Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                  child: TextField(
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.verified_user),
                        labelText: "Last Name",
                        fillColor: Colors.white,
                        filled: true
                    ),
                    controller: controller,
                  ),
                ),
              ),Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                  child: TextField(
                    decoration: new InputDecoration(
                        prefixIcon: Icon(Icons.verified_user),
                        labelText: "Post Code",
                        fillColor: Colors.white,
                        filled: true
                    ),
                    controller: controller,
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.only(bottom: 90.0, left: 10.0, right: 10.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 3.0,
                childAspectRatio: (itemWidth / itemHeight),
                scrollDirection: Axis.vertical,
                children: List.generate(filteredList.length, (index) {
                  return new GridTile(
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
                                          this.filteredList[index].destinationID.toString(),
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
                                      Icons.date_range,
                                      color: Colors.blueAccent,
                                      size: 40
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                        this.filteredList[index].date.toString(), //TODO: Should be phone number, not email.
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
                                      Icons.credit_card,
                                      color: Colors.blueAccent,
                                      size: 40
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0, left: 10.0),
                                        child: Text(
                                            "£ " + this.filteredList[index].cost.toString(), //TODO: Should be phone number, not email.
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
                                      Icons.access_time,
                                      color: Colors.blueAccent,
                                      size: 40
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                        this.filteredList[index].duration.toString() + " Day", //TODO: Should be phone number, not email.
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 23)
                                    ),
                                  ),
                                ],
                              )

                          )
                        ],
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
            debugPrint('FAB clicked');
          },
          tooltip: 'Add Customer',
          child: Icon(Icons.add),
        ),
      ),
    );
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

  void concurrentList(filter){
    print(filter);

    DateTime today = new DateTime.now();
    String dateSlug ="${today.year.toString()}/${today.month.toString().padLeft(2,'0')}/${today.day.toString().padLeft(2,'0')}";
    print(dateSlug);

    formatDate(DateTime(1989, 2, 21), [yyyy, '-', mm, '-', dd]);

    //filteredList = tripList.where((i) => DateTime.now().difference(DateTime.parse(i.date)).inDays > 0).toList();

  }

  void resetList(){
    filteredList = tripList;
  }

  void updateListView() {
    final Future<Database> dataInstance = databaseHelper.initializeDatabase();
    dataInstance.then((database) {
      Future<List<Trips>> customerListFuture = databaseHelper.getTripList();
      customerListFuture.then((tripList) {
        setState(() {

          this.tripList = tripList;
          this.filteredList = tripList;
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