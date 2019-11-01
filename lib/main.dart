import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Silver Dawn Coaches';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }

}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

//--------------------------------------------------------------------
class MyStructure {
  final int id;
  final String text;
  MyStructure({this.id, this.text});
}

class MyWidget extends StatelessWidget {
  final MyStructure widgetStructure;
  MyWidget(this.widgetStructure);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,

        color: Color.fromRGBO(33, 50, 85, 1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(34.0),
        ),

        child: Image.asset(
          'assets/blur1.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class InnerSwiper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _InnerSwiperState();
  }
}

class _InnerSwiperState extends State<InnerSwiper> {
  SwiperController controller;

  List<SwiperController> controllers;
  List<MyStructure> widgetList = [];

  @override
  void initState() {
    controller = new SwiperController();

    controllers = new List()
      ..length = 10
      ..fillRange(0, 10, new SwiperController());

    for(int i=0;i < 3; i++) {
      widgetList.add(MyStructure(id:i,text: ' this is index ${i}'));
    } /* This creates initial widgets in the list. You don't need to use the
    for loop. */

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        return new Swiper(
          loop: false,
          itemCount: widgetList.length,
          controller: controller,
          itemBuilder: (BuildContext context, int index) {
            return new Column(
              children: <Widget>[
                new SizedBox(
                  child: new Swiper(
                    controller: controllers[index],
                    itemCount: widgetList.length,
                    viewportFraction: 0.7,
                    scale: 0.9,
                    itemBuilder: (BuildContext context, int index) {
                      return MyWidget(widgetList[index]);
                    },
                  ),
                  height: MediaQuery.of(context).size.height * 0.55,
                ),
              ],
            );
          },
    );
  }
}

//------------------------------------------------------------------------------

class HomePage extends StatelessWidget { // This will be widgets for the home page.
  final Color color;
  HomePage(this.color);

  @override
  Widget build(BuildContext context){
    return Stack(
      children: <Widget>[
        Container(
          color: Color.fromRGBO(33, 50, 85, 1),
        ),
        MyHomePage()
      ],
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,

        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 100.0),
            height: MediaQuery.of(context).size.height * 0.55,
            child: IntrinsicHeight(child: InnerSwiper())
          )
        ]
    );
  }
}

//------------------------------------------------------------------------------

class LookupPage extends StatelessWidget{
  final Color color;

  LookupPage(this.color);

  @override
  Widget build(BuildContext context){
    return Stack(

      children: <Widget>[

        Container(
          color: color,

        )

      ],

    );
  }
}

class TripPage extends StatelessWidget{
  final Color color;

  TripPage(this.color);

  @override
  Widget build(BuildContext context){
    return Stack(
      children: <Widget>[
        Container(
           color: color,
        ),
      ],
    );
  }

}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    HomePage(Colors.yellow),
    LookupPage(Colors.deepOrange),
    TripPage(Colors.green)
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
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,


      ),
    );
  }
}

