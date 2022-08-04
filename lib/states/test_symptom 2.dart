import 'package:flutter/material.dart';

import 'package:flutter_application_1/states/selectman.dart';



class test_symptom2 extends StatefulWidget {
  test_symptom2({Key? key}) : super(key: key);

  @override
  _test_symptom2State createState() => _test_symptom2State();
}

class _test_symptom2State extends State<test_symptom2> {
  late double screenWidth, screenHeigth;

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text("Definition "),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 40.2,
        elevation: 0.00,
        backgroundColor: Colors.green.shade900,
      ),
      //AppBar
      body: SingleChildScrollView(
        child: Symptom(context),
      ),
    );
  }

  Container Symptom(BuildContext context) {
    return Container(
      width: 430,
      height: 750,
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("images/backgrond2.jpg"),
      )),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('ท่านมีอาการเหล่านี้หรือไม่ ? ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                 
                ],
              ),
        
              SizedBox(
                height: 20,
              ),
                     SizedBox(
                height: 500,
                width: 350,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 500,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/backg3.png"),
                            fit: BoxFit.contain,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 8),
                                blurRadius: 24,
                                color: Colors.grey.shade300)
                          ]),
                    ),
                    Positioned(
                      left: 10,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        height: 400,
                        width: MediaQuery.of(context).size.width - 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "รายละเอียดอาการ ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "อาการ 1 ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "อาการ 2 ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "อาการ 3 ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " หากมีอาการรุนแรง หรือมีอาการอื่นร่วมด้วย",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "",
                              maxLines: 22,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [Nobutton(),yesbutton()],
              )
              
            ],
          ),
        ),
      ]),
    );
  }
Container yesbutton() {
    return Container(
      padding: EdgeInsets.all(25),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          child: Text('ใช่'),
          onPressed: () {
             showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopup(context),
              );
          },
          style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15.0),
              ), primary: Colors.green.shade900,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
  Container Nobutton() {
    return Container(
      padding: EdgeInsets.all(25),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          child: Text('ไม่'),
          onPressed: () {
            Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new selectman()));
          },
          style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15.0),
              ), primary: Colors.green.shade900,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
  Widget _buildPopup(BuildContext context) {
    return new AlertDialog(
        title: Container(
          alignment: Alignment.center,
          child: const Text('!! เตือน !!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.red)),
        ),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("ควรรีบพบแพทย์",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color: Colors.red)),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             
              new ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new selectman()));
                },
                style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ), primary: Colors.green.shade900,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
        elevation: 10,
       );
  }
  
}

