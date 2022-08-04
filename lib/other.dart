import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utility/my_style.dart';
class other extends StatefulWidget {
  other({Key? key}) : super(key: key);

  @override
  _otherState createState() => _otherState();
}

class _otherState extends State<other> {
  var selectedOrgan;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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
        body: SafeArea(
            child: Container(
                child: Stack(
          children: [
            MyStyle().buildbackgrond2(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dropdownbutton_organ(),
                  SizedBox(height: 20),
                  Container(
                      width: 400,
                      height: 400,
                      child: Image(
                        image: AssetImage('images/อื่นๆ.png'),
                      )),
                  SizedBox(height: 20),
                  yesbutton()
                ],
              ),
            ),
          ],
        ))));
  }
StreamBuilder<QuerySnapshot<Object?>> dropdownbutton_organ() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("organ").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            const Text("Loading.....");
          else {
            List<DropdownMenuItem> OrganItems = [];

            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              DocumentSnapshot snap = snapshot.data!.docs[i];
              OrganItems.add(
                DropdownMenuItem(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      snap.id,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  value: "${snap.id}",
                ),
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 50.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade900,
                    border: Border.all(color: Colors.green.shade900),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<dynamic>(
                        dropdownColor: Colors.green.shade900,
                        alignment: Alignment.center,
                        items: OrganItems,
                        onChanged: (OrganValue) {
                          setState(() {
                            selectedOrgan = OrganValue;
                          });
                        },
                        value: selectedOrgan,
                        isExpanded: false,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                        iconSize: 40,
                        hint: Text(
                            "เลือกอาการ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return Row();
        });
  }


  Container yesbutton() {
    return Container(
      padding: EdgeInsets.all(25),
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          child: Text('ยืนยัน'),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15.0),
              ), primary: Colors.green.shade900,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
