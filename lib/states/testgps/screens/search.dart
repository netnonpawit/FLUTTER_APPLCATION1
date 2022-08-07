import 'package:flutter/material.dart';
import 'package:flutter_application_1/states/testgps/screens/gps_model.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Position? userLocation;
  GoogleMapController? mapController;
   final controller  = ScrollController();
  List<Marker> allMarkers = [];
  PageController? _pageController;
  int? prevPage;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lacation.forEach((element) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.locatorName),
          draggable: false,
          infoWindow:
              InfoWindow(title: element.locatorName, snippet: element.address),
          position: element.locationCoords));
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController?.page!.toInt() != prevPage) {
      prevPage = _pageController?.page as int;
      moveCamera();
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  _locatorList(index) {
    return AnimatedBuilder(
      animation: _pageController!,
      builder: (BuildContext context, Widget? child) {
        double value = 1;
        if (_pageController!.position.haveDimensions) {
          value = _pageController!.page ?? -index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
            child: SizedBox(
          height: Curves.easeInOut.transform(value) * 125.0,
          width: Curves.easeInOut.transform(value) * 350.0,
          child: widget,
        ));
      },
      child: InkWell(
          onTap: () {
            moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          lacation[index].thumNail),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lacation[index].locatorName,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  lacation[index].address,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  width: 170.0,
                                  child: Text(
                                    lacation[index].description,
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ])
                        ]))))
          ])),
    );
  }

  Future<Object?> _getLocation() async {
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
        body: Stack(children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: _getLocation(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: GoogleMap(
                        mapType: MapType.normal,
                        onMapCreated: _onMapCreated,
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(14.9839039, 103.0763868),
                            //LatLng(userLocation.latitude, userLocation.longitude),
                            zoom: 15),
                        markers: Set.from(allMarkers),
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
              )),
         
       
              
         

          /*floatingActionButton: FloatingActionButton.extended(
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
      ),*/
        ]));
  }

  moveCamera() {
    mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: lacation[_pageController!.page!.toInt()].locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}
