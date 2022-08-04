import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class lacator {
  String locatorName;
  String address;
  String descripstion;
  String thumNail;
  LatLng locationCoords;
  //Image image;

  lacator(
      {required this.locatorName,
      required this.address,
      required this.descripstion,
      required this.thumNail,
      required this.locationCoords,
      //required this.image});
      });
}
final List<lacator> lacation = [
  lacator(
      locatorName: 'ChangArena',
      address: '18 W 29th St',
      descripstion:
          'ChangArena Football Stadium',
      locationCoords: LatLng(14.9658746, 103.0921753),
      thumNail: 'https://lh5.googleusercontent.com/p/AF1QipNNzoa4RVMeOisc0vQ5m3Z7aKet5353lu0Aah0a=w90-h90-n-k-no'
      ),
  
];
