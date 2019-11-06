import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'customers.dart';
import 'database_helper.dart';

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
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: TextField(
        controller: key.currentState.textEditingControllers[controllerValue],
        style: textStyle,
        decoration: InputDecoration(
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

  var textEditingControllers = <TextEditingController>[];

  CustomerDetailState(this.customer, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    customer.variableList.forEach((str) {
      var textEditingController = new TextEditingController(text: str);
      textEditingControllers.add(textEditingController);
    });

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

          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[

                CustomField(fieldHint: "First Name", controllerValue: 0),
                CustomField(fieldHint: "Last Name", controllerValue: 1),
                CustomField(fieldHint: "Adress", controllerValue: 2),
                CustomField(fieldHint: "Postcode", controllerValue: 3),
                CustomField(fieldHint: "Email", controllerValue: 4),
                CustomField(fieldHint: "Phone Number", controllerValue: 5),
                CustomField(fieldHint: "Special Requirements", controllerValue: 6),

                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
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

                      Container(width: 5.0,),

                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Delete button clicked");
                              _delete();
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                ),


              ],
            ),
          ),

        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Save data to database
  void _save() async {

    customer.firstName = textEditingControllers[0].text;
    customer.lastName = textEditingControllers[1].text;
    customer.address = textEditingControllers[2].text;
    customer.postCode = textEditingControllers[3].text;
    customer.phoneNumber = textEditingControllers[4].text;
    customer.email = textEditingControllers[5].text;
    customer.requirements = textEditingControllers[6].text;

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