import 'package:flutter/material.dart';
import 'package:flutter_application_1/states/test_gps.dart';

import 'package:flutter_application_1/states/testgps/screens/search.dart';


import 'package:flutter_application_1/utility/my_style.dart';

class firstsceen extends StatefulWidget {
  firstsceen({Key? key}) : super(key: key);

  @override
  _firstsceenState createState() => _firstsceenState();
}

class _firstsceenState extends State<firstsceen> {
  late double screenWidth, screenHeigth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Stack(
          children: [
            MyStyle().buildbackgrond(),
            Container(
              alignment: Alignment.topCenter,
              child: Image(
                  image: AssetImage('images/logo.png'), fit: BoxFit.cover),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      manbutton(),
                      
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Container manbutton() {
    return Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/man.png'))),
                              child: TextButton(onPressed: () {
                                Navigator.push(context, new MaterialPageRoute(
   builder: (context) => new Search()));
                              }, child: Text('') ),
                    );
  }

 

}