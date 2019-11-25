import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'customers.dart';
import 'database_helper.dart';

class CustomerViewer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CustomerViewerState();
  }
}

class CustomerViewerState extends State<CustomerViewer> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Customers> customerList;
  List<Customers> filteredList = [];
  List<Customers> filteredLastName = [];
  int count = 0;

  TextEditingController controller = new TextEditingController();
  TextEditingController postCodeController = new TextEditingController();

  String filter;
  String postCodeFilter;

  @override
  initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
        postCodeFilter = postCodeController.text;

        if(filter != null && filter != ""){
          concurrentList(filter);
        } else{
          resetList();
        }

        if(postCodeFilter != null && postCodeFilter != ""){
          concurrentList(postCodeFilter);
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

    if (customerList == null) {
      customerList = List<Customers>();
      updateListView();
    }

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 70, 76, 1),
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
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                // Generate 100 widgets that display their index in the List.
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
                                      this.filteredList[index].firstName + ' ' +  this.filteredList[index].lastName,
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
                                      this.filteredList[index].phoneNumber, //TODO: Should be phone number, not email.
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
                                            this.filteredList[index].email, //TODO: Should be phone number, not email.
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
                                        this.filteredList[index].postCode, //TODO: Should be phone number, not email.
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

  void _delete(BuildContext context, Customers customer) async {
    int result = await databaseHelper.deleteCustomer(customer.customerID);
    if (result != 0) {
      _showSnackBar(context, 'Customer Deleted Successfully');
      updateListView();
    }
  }

  void concurrentList(filter){
    print(filter);
    filteredList = customerList.where((i) => i.firstName.contains(filter)).toList();

  }

  void resetList(){
    filteredList = customerList;
  }

  void updateListView() {
    final Future<Database> dataInstance = databaseHelper.initializeDatabase();
    dataInstance.then((database) {
      Future<List<Customers>> customerListFuture = databaseHelper.getCustomerList();
      customerListFuture.then((customerList) {
        setState(() {

            this.customerList = customerList;
            this.filteredList = customerList;
            this.count = customerList.length;

        });
      });
    });
  }


  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }


}