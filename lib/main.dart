import 'package:flutter/material.dart';

import 'package:flutter_application_1/utility/route.dart';
import 'package:firebase_core/firebase_core.dart';


String initRoute = '/fistsceen';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
   MaterialApp(routes: map, initialRoute: initRoute);
   
  }
}
