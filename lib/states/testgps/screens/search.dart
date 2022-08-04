

import 'package:flutter/material.dart';
import 'package:flutter_application_1/states/testgps/screens/gps_model.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late Position userLocation;
  late GoogleMapController mapController;

  List<Marker> allMarkers = [];
   late PageController _pageController;
   late int prevPage;
  
  @override
  void initState(){
     super.initState();
     lacation.forEach((element) {
       allMarkers.add(Marker(markerId: MarkerId(element.locatorName),draggable: false,infoWindow:InfoWindow(title: element.locatorName,snippet: element.address)
       ,position: element.locationCoords));
     });
     _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }
   void _onScroll() {
    if (_pageController.page as int  != prevPage) {
      prevPage = _pageController.page as int;
      moveCamera();
    }
  }
  
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

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }

  Marker ChangArena = Marker(
      markerId: MarkerId('ChangArena'),
      position: LatLng(14.9658746, 103.0921753),
      infoWindow: InfoWindow(title: 'ChangArena'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
  Marker BRH = Marker(
      markerId: MarkerId('BRH'),
      position: LatLng(15.005684, 103.0985359),
      infoWindow: InfoWindow(title: 'BRH'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
  Marker HomeProBR = Marker(
      markerId: MarkerId('HomeProBR'),
      position: LatLng(14.9839039, 103.0763868),
      infoWindow: InfoWindow(title: 'HomeProBR'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
      
     
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Google Maps'),
      ),
      body:Stack(children: <Widget>[
        Container(
           child: FutureBuilder(
          future: _getLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    target:LatLng(14.9839039, 103.0763868),
                        //LatLng(userLocation.latitude, userLocation.longitude),
                    zoom: 15),
                    markers: Set.from(allMarkers),
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
        )
        ),
       Positioned(child: Container(height: 200.0,
       width: MediaQuery.of(context).size.width,
       child:PageView.builder(  controller: _pageController,
                  itemCount: locator.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _locatorList(index);} ,))
      )],
      
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

  moveCamera() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: locator[_pageController.page.toInt()].locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}

