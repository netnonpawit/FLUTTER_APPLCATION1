
import 'package:flutter/material.dart';
import 'package:flutter_application_1/states/testdb.dart';
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildbutton1(),
                  SizedBox(
                    height: 30,
                  ),
                  buildbutton2()
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  ElevatedButton buildbutton1() {
    return ElevatedButton(
      child: Text('วินิจฉัยโรค'),
      onPressed: () { 
        Navigator.push(context, new MaterialPageRoute(
   builder: (context) => new testdb()));
 },
      style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(28.0),
          ),
          primary: Colors.green.shade900,
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 13),
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}

ElevatedButton buildbutton2() {
  return ElevatedButton(
    child: Text('หาโรงพยาบาล'),
    onPressed: () {},
    style: ElevatedButton.styleFrom(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(28.0),
        ),
        primary: Colors.green.shade400,
        padding: EdgeInsets.symmetric(horizontal: 46, vertical: 13),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  );
}
