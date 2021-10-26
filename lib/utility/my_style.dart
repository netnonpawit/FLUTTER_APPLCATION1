import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Color(0xff2bbd7e);
  Color primaryColor = Color(0xff69f0ae);
  Color ligthColor = Color(0xff9fffe0);

  Scaffold buildbackgrond() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/backgrond1.jpg'), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
