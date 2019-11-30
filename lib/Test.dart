import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:silver_dawn/trip_lookup.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'trips.dart';
import 'package:date_format/date_format.dart';
import 'package:silver_dawn/ViewTrip.dart';
import 'database_helper.dart';
import 'customers.dart';
import 'cities.dart';

class CustomField extends StatefulWidget {
  CustomField({this.fieldHint, this.controllerValue});

  final String fieldHint;
  final int controllerValue;

  @override
  _CustomFieldState createState() => new _CustomFieldState(fieldHint, controllerValue);
}

final key = new GlobalKey<CustomerDetailState>();

class _CustomFieldState extends State<CustomField> {
  String fieldHint;
  int controllerValue;

  _CustomFieldState(this.fieldHint, this.controllerValue);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: 0.0, left: 10.0, right: 10.0),
      child: TextField(
        controller: key.currentState.textEditingControllers[controllerValue],
        style: new TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.05,
            color: Colors.black
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.add_circle),
            labelText: fieldHint,
            labelStyle: textStyle,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0)
            )
        ),
      ),
    );
  }
}

class globalSetup extends StatefulWidget {

  final String appBarTitle;
  final Customers customer;

  globalSetup(this.customer, this.appBarTitle);

  @override
  _globalSetupState createState() => new _globalSetupState(appBarTitle, customer);
}

class _globalSetupState extends State<globalSetup>{
  String appBarTitle;
  Customers customer;

  _globalSetupState(this.appBarTitle, this.customer);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomerDetail(key: key, customer: customer, appBarTitle: appBarTitle);
  }
}

class CustomerDetail extends StatefulWidget {

  CustomerDetail({Key key, this.customer, this.appBarTitle}) : super(key: key);

  final String appBarTitle;
  final Customers customer;

  State createState() => new CustomerDetailState(this.customer, this.appBarTitle);
}

class CustomerDetailState extends State<CustomerDetail> {

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Customers customer;

  List<Cities> cityList;
  int cityCount;

  int currentIndex;

  DatabaseHelper databaseHelper = DatabaseHelper();

  var textEditingControllers = <TextEditingController>[];

  CustomerDetailState(this.customer, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    customer.variableList.forEach((str) {
      var textEditingController = new TextEditingController(text: str);
      textEditingControllers.add(textEditingController);
    });

    if (cityList == null) {
      cityList = List<Cities>();
      updateCityListView();
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
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                  child: ListView(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 10.0, right: 10.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 25.0, bottom: 0.0, left: 10.0, right: 10.0),
                              child: Icon(
                                  Icons.supervised_user_circle,
                                  color: Colors.red,
                                  size: 104,
                              ),
                            ),
                            Expanded(
                                child: CustomField(fieldHint: "First Name", controllerValue: 0),
                            ), Expanded(
                                child: CustomField(fieldHint: "Last Name", controllerValue: 1),
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 0.0, left: 10.0, right: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: CustomField(fieldHint: "Address Line 1", controllerValue: 2),
                            ),
                            Expanded(
                              child: CustomField(fieldHint: "Address Line 2", controllerValue: 3),
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: CustomField(fieldHint: "Town/City", controllerValue: 4),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: CustomField(fieldHint: "Postcode", controllerValue: 5),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: CustomField(fieldHint: "Email", controllerValue: 6)
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: CustomField(fieldHint: "Phone Number", controllerValue: 7),
                      ),

                      Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                          child: CustomField(fieldHint: "Special Requirements", controllerValue: 8),
                      ),


                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,

                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      'Create Customer',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        debugPrint("Save button clicked");
                        _save();
                      });
                    },
                  ),
                ),
              ),

            ],

          ),

        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Save data to database
  void _save() async {

    final emailCheck = RegExp(r"(^[a-z0-9_.+-]+@[a-z0-9-]+\.[a-z0-9-.]+$)");
    final alphaCheck = RegExp(r"^[a-zA-Z]*$");

    if((textEditingControllers[0].text == "")
        || (textEditingControllers[0].text == null)
        || (!alphaCheck.hasMatch(textEditingControllers[0].text))){
      _showDialog("Error", "Please enter a valid first name");
    } else if((textEditingControllers[1].text == "")
        || (textEditingControllers[1].text == null)
        || (!alphaCheck.hasMatch(textEditingControllers[1].text))){
      _showDialog("Error", "Please enter the customer's last name");
    } else if((textEditingControllers[2].text == "")
        || (textEditingControllers[2].text == null)
        || (!alphaCheck.hasMatch(textEditingControllers[2].text))){
      _showDialog("Error", "Please enter the customer's first line address");
    } else if((textEditingControllers[3].text == "")
        || (textEditingControllers[3].text == null)
        || (!alphaCheck.hasMatch(textEditingControllers[3].text))){
      _showDialog("Error", "Please enter the customer's second line address");
    } else if((textEditingControllers[4].text == "")
        || (textEditingControllers[4].text == null)
        || (!alphaCheck.hasMatch(textEditingControllers[4].text))){
      _showDialog("Error", "Please enter the customer's town/city");
    } else if((textEditingControllers[5].text == "")
        || (textEditingControllers[5].text == null)
        || (!alphaCheck.hasMatch(textEditingControllers[5].text))){
      _showDialog("Error", "Please enter the customer's postcode");
    } else if((textEditingControllers[6].text == "")
        || (textEditingControllers[6].text == null)
        || (!alphaCheck.hasMatch(textEditingControllers[6].text))){
      _showDialog("Error", "Please enter the customer's phone number");
    } else if((textEditingControllers[7].text == "")
        || (textEditingControllers[7].text == null)
        || (!alphaCheck.hasMatch(textEditingControllers[7].text))){
      _showDialog("Error", "Please enter the customer's email");
    } else{

      if(textEditingControllers[0].text.length > 50){
        _showDialog("Error", "Please enter a valid first name");
      } else if(textEditingControllers[1].text.length > 50){
        _showDialog("Error", "Please enter a valid last name");
      } else if(textEditingControllers[2].text.length > 45){
        _showDialog("Error", "Please enter a valid first line address");
      } else if(textEditingControllers[3].text.length > 45){
        _showDialog("Error", "Please enter a valid second line address");
      } else if(textEditingControllers[4].text.length > 45){
        _showDialog("Error", "Please enter a valid town/city");
      } else if(textEditingControllers[5].text.length > 7){
        _showDialog("Error", "Please enter a valid postcode");
      } else if(textEditingControllers[6].text.length > 255){
        _showDialog("Error", "Please enter a valid email");
      } else if(textEditingControllers[7].text.length > 12){
        _showDialog("Error", "Please enter a valid phone number");
      } else if(textEditingControllers[8].text.length > 350){
        _showDialog("Error", "Please enter valid requirements. ");
      } else if(!emailCheck.hasMatch(textEditingControllers[6].text)){
        _showDialog("Error", "Please enter a valid email format. ");
      }
      else{
        customer.firstName = textEditingControllers[0].text;
        customer.lastName = textEditingControllers[1].text;
        customer.address = textEditingControllers[2].text;
        customer.address2 = textEditingControllers[3].text;

        //customer.town = textEditingControllers[4].text;
        var cityNameList = [];

        for(var i = 0; i < cityList.length; i++){
          cityNameList.add(cityList[i].name.toLowerCase());
        }

        print(cityNameList);

        if(cityNameList.contains(textEditingControllers[4].text.toLowerCase())){
          currentIndex = cityNameList.indexOf(textEditingControllers[4].text.toLowerCase()) + 1;
        } else{
          currentIndex = cityNameList.length + 1;
          helper.insertCity(Cities(textEditingControllers[4].text));
        }

        print(currentIndex);

        customer.town = currentIndex;
        customer.postCode = textEditingControllers[5].text;
        customer.email = textEditingControllers[6].text;
        customer.phoneNumber = textEditingControllers[7].text;

        if(textEditingControllers[8].text == "" || textEditingControllers[8].text == null){
          customer.requirements = null;
        } else{
          customer.requirements = textEditingControllers[8].text;
        }

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
    }
  }


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

  void updateCityListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Cities>> cityListFuture = databaseHelper.getCity();
      cityListFuture.then((cityList) {
        setState(() {

          this.cityList = cityList;
          this.cityCount = cityList.length;

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