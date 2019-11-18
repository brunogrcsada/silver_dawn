import 'package:flutter/material.dart';
import 'LookupPage.dart';
import 'ViewCustomers.dart';
import 'TripPage.dart';
import 'HomePage.dart';
import 'database_helper.dart';


void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Silver Dawn Coaches';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyStatefulWidget(),
    );
  }

}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    HomePage(Colors.yellow), //TODO: This is how we call widgets using functions. Use it to your advantage.
    CustomerViewer(),
    TripPage() // TODO: THIS WORKS!!!!!
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          Center(child: _widgetOptions.elementAt(_selectedIndex)),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: bottomNavigationBar,
          ),
        ],
      ),

    );
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.zoom_in),
              title: Text('Lookup'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_travel),
              title: Text('Trips'),
            ),
          ],

          currentIndex: _selectedIndex,
          iconSize: 30,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,


      ),
    );
  }
}

