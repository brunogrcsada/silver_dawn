import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:animator/animator.dart';

class HomePage extends StatelessWidget { // This will be widgets for the home page.
  final Color color;
  HomePage(this.color);

  @override
  Widget build(BuildContext context){
    return Stack(
      children: <Widget>[
        Container(
          color: Color.fromRGBO(255, 70, 76, 1),
        ),
        MyHomePage()
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,

        children: <Widget>[
          Animator(
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
                  'assets/logo.png',
                  height: 220.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 70.0, top: 10.0),
              height: MediaQuery.of(context).size.height * 0.55,
              child: IntrinsicHeight(child: InnerSwiper())
          )
        ]
    );
  }
}

class MyStructure {
  final int id;
  final String text;
  MyStructure({this.id, this.text});
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

    //TODO: Can I engineer a function widget to create a custom card for each.

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
                viewportFraction: 0.8,
                scale: 0.9, //TODO: Change the scale (Refer to Stanley)
                index: 0,
                loop: false,
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

class MyWidget extends StatelessWidget {
  final MyStructure widgetStructure;
  MyWidget(this.widgetStructure);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0), // TODO: Redesign margin.

      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,

        color: Color.fromRGBO(2, 2, 2, 1),
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(34.0),
        ),

        child: GestureDetector(
          onTap: (){
            print("tapped");
          },

          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                'assets/customer.png',
                fit: BoxFit.cover,
              ), Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconShadowWidget(Icon(Icons.add_circle,
                          color: Colors.white, size: 126),
                        showShadow: true, shadowColor: Colors.black,),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'New Customer',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),

        ),
      ),
    );
  }
}