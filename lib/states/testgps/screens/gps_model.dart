
import 'package:google_maps_flutter/google_maps_flutter.dart';

class locator {
  String locatorName;
  String address;
  String description;
  String thumNail;
  LatLng locationCoords;
  //Image image;

  locator(
      {required this.locatorName,
      required this.address,
      required this.description,
      required this.thumNail,
      required this.locationCoords,
      //required this.image});
      });

  static void forEach(Null Function(dynamic element) param0) {}
}
final List<locator> lacation = [
  locator(
      locatorName: 'ChangArena',
      address: '18 W 29th St',
      description:
          'ChangArena Football Stadium',
      locationCoords: LatLng(14.9658746, 103.0921753),
      thumNail: ''
      ),
  locator(
      locatorName: 'BRH',
      address: '18 W 29th St',
      description:
          'Buriram Hospital',
      locationCoords: LatLng(15.005684, 103.0985359),
      thumNail: ''
      ),
];
