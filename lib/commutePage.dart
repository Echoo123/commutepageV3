import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CommutePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<CommutePage> {
  Completer<GoogleMapController> _controller = Completer();

  // Work
  static LatLng _work = LatLng(43.6577, -79.3788);
  static final CameraPosition _camWork = CameraPosition(
    target: _work,
    zoom: 16,
  );

  // Home
  static LatLng _home = LatLng(43.734664846231205, -79.37423021927064);
  static final CameraPosition _camMum = CameraPosition(
    target: _home,
    zoom: 16,
  );

  static const LatLng _center =
      const LatLng(43.734664846231205, -79.37423021927064);
  // Code added
  // Adding mapType
  MapType _currentMapType = MapType.normal;
  // Marker
  final Set<Marker> _markers = {};

  // Tracking current location
  LatLng _lastMapPosition = _center;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Commute'),
          backgroundColor: Colors.cyan,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              mapType: _currentMapType, // Map type
              markers: _markers, // markers
              onCameraMove: _onCameraMove, // Moves camera
              myLocationEnabled: true, // shows user location
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 16.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: FloatingActionButton(
                        onPressed: _onMapTypeButtonPressed,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.cyan,
                        child: const Icon(Icons.map, size: 24.0),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: FloatingActionButton(
                        onPressed: _onAddMarkerButtonPressed,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.cyan,
                        child: const Icon(Icons.add_location, size: 24.0),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: FloatingActionButton(
                        onPressed: _gotowork,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.work, size: 24.0),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: FloatingActionButton(
                        onPressed: _gotoPlace,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.home, size: 24.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Future<void> _gotowork() async {
    //Fly camera there
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_camWork));

    // Mark it
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _work,
        infoWindow: InfoWindow(
          title: 'Work',
        ),
      ));
    });
  }

  Future<void> _gotoPlace() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_camMum));

    // Mark it
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _home,
        infoWindow: InfoWindow(
          title: 'Home',
        ),
      ));
    });
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
      print(_currentMapType);
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Destination',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
}
