import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 3, 3, 0.5),

        ), child: BottomNavigator(),
      ),
    );
  }
}

class BottomNavigator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Positioned(
            child: Column(
              children: <Widget>[
                new Container(
                  alignment: Alignment.bottomCenter,

                  child: Card( // TODO: Create logout, statistics and user profile button at the top (With row)
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,

                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.only(
                          bottomLeft: const Radius.circular(20.0),
                          bottomRight: const Radius.circular(20.0)),

                      side: BorderSide(
                        color: Colors.white,
                        width: 3,
                      ),

                    ),

                    color: Colors.black87,
                    child: Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 40.0, top: 30.0),
                              width: 50,
                              height: 50,
                              child: new Container(
                                  child: new Image.asset(
                                    'assets/round_exit_to_app_white_18.png',
                                    height: 30.0,
                                    fit: BoxFit.cover,
                                  )

                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 40.0, top: 30.0),
                              width: 50,
                              height: 50,
                              child: new Container(
                                child: new Image.asset(
                                  'assets/open_graph.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.bottomCenter,
                            height: MediaQuery.of(context).size.height * 0.36,

                            child: new Container(
                              margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 20.0),
                              width: MediaQuery.of(context).size.width,
                              height: double.infinity,

                              child: new Card(
                                  shape: RoundedRectangleBorder(

                                    borderRadius: new BorderRadius.only(
                                      bottomLeft: const Radius.circular(20.0),
                                      bottomRight: const Radius.circular(20.0),
                                      topLeft: const Radius.circular(20.0),
                                      topRight: const Radius.circular(20.0),
                                    ),

                                    side: BorderSide(
                                      color: Colors.grey,
                                      width: 5,
                                    ),
                                  ),
                                  child: new Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 18.0),
                                          width: MediaQuery.of(context).size.width,

                                          child: GestureDetector(
                                            onTap: () {  // TODO: Open a popup to create new Party.
                                              Scaffold.of(context).showSnackBar(SnackBar(
                                                content: Text('Unable to create a new party.'),
                                              ));
                                            },
                                            child: Card(
                                                elevation: 10,
                                                color: Color.fromRGBO(36, 41, 80, 1),
                                                shape: RoundedRectangleBorder(

                                                  borderRadius: new BorderRadius.only(
                                                    bottomLeft: const Radius.circular(20.0),
                                                    bottomRight: const Radius.circular(20.0),
                                                    topLeft: const Radius.circular(20.0),
                                                    topRight: const Radius.circular(20.0),
                                                  ),

                                                  side: BorderSide(
                                                    color: Colors.white,
                                                    width: 5,
                                                  ),

                                                ),

                                                child: new Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    new Container(
                                                        child: new Image.asset(
                                                          'assets/round_gamepad_white_18.png',
                                                          height: 50.0,
                                                          fit: BoxFit.cover,
                                                        )
                                                    ), Container(

                                                      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 0.0),
                                                      child: new Text(
                                                        "Create a Party",
                                                        style: new TextStyle(
                                                          fontSize: 20.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )

                                            ),
                                          ),



                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
                                          width: MediaQuery.of(context).size.width,

                                          child: Card(
                                              color: Color.fromRGBO(30, 30, 30, 1),
                                              shape: RoundedRectangleBorder(

                                                borderRadius: new BorderRadius.only(
                                                  bottomLeft: const Radius.circular(20.0),
                                                  bottomRight: const Radius.circular(20.0),
                                                  topLeft: const Radius.circular(20.0),
                                                  topRight: const Radius.circular(20.0),
                                                ),


                                              ),

                                              child: new Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  new Container(
                                                      child: new Image.asset(
                                                        'assets/round_group_white_18.png',
                                                        height: 50.0,
                                                        fit: BoxFit.cover,
                                                      )
                                                  ), Container(

                                                    margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 0.0),
                                                    child: new Text(
                                                      "Join a Party",
                                                      style: new TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )

                                          ),


                                        ),
                                      ),

                                    ],
                                  )

                              ),
                            )
                        ),
                      ],
                    ),

                  ),
                ),


              ],
            )
        ),
      ],
    );
  }
}
