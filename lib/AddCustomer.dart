import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

//MyStructure(id:0,text: 'New Customer', icon: Icons.add_circle, directory: 'assets/customer.png')

class CustomField extends StatefulWidget {
  CustomField({Key key, this.icon, this.fieldHint}) : super(key: key);

  final IconData icon;
  final String fieldHint;

  @override
  _CustomFieldState createState() => new _CustomFieldState(icon, fieldHint);
}


class _CustomFieldState extends State<CustomField> {
  IconData icon;
  String fieldHint;

  _CustomFieldState(this.icon, this.fieldHint);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
        style: TextStyle(
          fontSize: 19.0,
          color: Colors.white,
        ),
        decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromRGBO(255, 255, 255, 0.4),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            prefixIcon: Icon(icon),
            hintStyle: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.7)
            ),
            hintText: fieldHint,

            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(19.0)),

            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(19.0)
            )
        )
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 70, 76, 1),
      appBar: AppBar(
        title: Text("New Customer"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 30.0, left: 30.0),
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.person_add,
                  size: 130,
                  color: Colors.white,
                ),
              ), Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
                      child: CustomField(icon: Icons.contacts, fieldHint: "First Name..."), // Simple implementation now.
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 17.0, left: 10.0, right: 10.0),
                      child: CustomField(icon: Icons.person_outline, fieldHint: "Last Name..."),

                    ),
                  ],
                ),
              ),
            ],
          ),Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 5.0),
                    child: CustomField(icon: Icons.contacts, fieldHint: "Address"), // Simple implementation now.
                  ),
                ), Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 5.0, top: 20.0, right: 10.0),
                  child: CustomField(icon: Icons.contacts, fieldHint: "Post Code"), // Simple implementation now.
                ),
              )
            ],
          ),Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 5.0),
              child: CustomField(icon: Icons.contacts, fieldHint: "Address"), // Simple implementation now.
          ),Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 5.0),
            child: CustomField(icon: Icons.contacts, fieldHint: "Email..."), // Simple implementation now.
          ),Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 5.0),
            child: CustomField(icon: Icons.contacts, fieldHint: "Phone Number..."), // Simple implementation now.
          ),Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 5.0),
            child: CustomField(icon: Icons.contacts, fieldHint: "Date of Birth..."), // Simple implementation now.
          ),Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20.0, top: 20.0, right: 5.0),
            child: CustomField(icon: Icons.contacts, fieldHint: "Special Requirements..."), // Simple implementation now.
          ),Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: GestureDetector(
              onTap: (){

              },
              child: Card(

              ),
            ),
          )

        ],
      )
    );
  }
}