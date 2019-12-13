import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'main.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Silver Dawn Coaches';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primarySwatch: Colors.red,
    ),
      home: MainLogin(),
    );
  }

}

class MainLogin extends StatefulWidget {
  MainLogin({Key key}) : super(key: key);


  @override
  _MainLoginState createState() => new _MainLoginState();
}

class _MainLoginState extends State<MainLogin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromRGBO(255, 70, 76, 1),
     body: SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.only(top:90.0),
         child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisSize: MainAxisSize.max,
               mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                Center(
                  child: Animator(
                    tweenMap: {
                      "opacity": Tween<double>(begin: 0, end: 1),
                      "translation": Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
                    },
                    cycles: 1,
                    duration: Duration(milliseconds: 500),
                    builderMap: (Map<String, Animation> anim) => FadeTransition(
                      opacity: anim["opacity"],
                      child: FractionalTranslation(
                        translation: anim["translation"].value,
                        child: new Image.asset(
                          'assets/logo.png', //TODO: make logo transparent to remove box color difference.
                          height: 220.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 70,
                  child: Card(
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: 50,
                          child: Icon(
                            Icons.email,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right:8.0, top:8.0, bottom:8.0),
                            child: TextField(
                              style: new TextStyle(
                                color: Colors.black,
                                fontSize: 20
                              ),
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 70,
                  child: Card(
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: 50,
                          child: Icon(
                            Icons.lock,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right:8.0, top:8.0, bottom:8.0),
                            child: TextField(
                              obscureText: true,
                              style: new TextStyle(
                                  color: Colors.black,
                                  fontSize: 20
                              ),
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:13.0),
                  child: FlatButton(
                    color: Color.fromRGBO(255, 252, 9, 1),
                    textColor: Colors.black,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.only(top:15.0, bottom: 15.0, left: 162.0, right: 162.0),
                    splashColor: Colors.blueAccent,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyStatefulWidget()),
                      );
                    }, child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  ),
                )

              ]
          ),
       ),
     ),

    );
  }
}
