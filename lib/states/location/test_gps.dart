import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Mapsample extends StatefulWidget {
  const Mapsample({Key? key}) : super(key: key);

  @override
  State<Mapsample> createState() => _MapsampleState();
}

class _MapsampleState extends State<Mapsample> {
   late Position userLocation;
  late  GoogleMapController mapController;
   Set<Polyline> _polylines = Set<Polyline>();
   List<LatLng>polylineCoordiates =[];
   late PolylinePoints polylinePoints ;
   late StreamSubscription<LocationData>subscription;
   late LocationData currentLocation;
   late LocationData destinationLocation;
   late Location location;
   
   @override
   /*void initState();{
    super.initState();
    location = Location();
    polylinePoints = PolylinePoints();

    location.onLocationChanged.listen((clocation) { 
      currentLocation = clocation;
    });
    
   }*/

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
   
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

  //userLocation = await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high);

    return userLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Google Maps'),
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                mapType: MapType.normal,
                markers: {
                  ChangArena,BRH,Mylocation
                },
                onMapCreated:_onMapCreated,//(controller) => mapController =  controller,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  //target: LatLng(14.99433, 103.10392),
                  target: LatLng(userLocation.latitude,userLocation.longitude),
                    zoom: 15),
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          mapController.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(userLocation.latitude, userLocation.longitude), 18));
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    'Your location has been send !\nlat: ${userLocation.latitude} long: ${userLocation.longitude} '),
              );
            },
          );
        },
        label: Text("Send Location"),
        icon: Icon(Icons.near_me),
      ),
    );
  }

  Marker ChangArena = Marker(
      markerId: MarkerId('ChangArena'),
      position: LatLng(14.9658746, 103.0921753),
      infoWindow: InfoWindow(title: 'ChangArena'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
  Marker BRH = Marker(
      markerId: MarkerId('BRH'),
      position: LatLng(15.005684,103.0985359),
      infoWindow: InfoWindow(title: 'BRH'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
    Marker Mylocation = Marker(
      markerId: MarkerId('Mylocation '),
      position: LatLng(14.9772822,103.0717456),
      infoWindow: InfoWindow(title: 'Mylocation '),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
}
