import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:live_location/services/geolocator_service.dart';

class Map extends StatefulWidget {

  final Position initialPosition;

  Map(this.initialPosition);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

  final GeoLocatorService geoService = GeoLocatorService();

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    geoService.getCurrentLocation().listen((position) {
      centerScreen(position);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(
                  widget.initialPosition.latitude, widget.initialPosition.longitude
              ),
              zoom: 18.0
          ),
          mapType: MapType.satellite,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }

  Future<void> centerScreen(Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 18.0
    )
    )
    );
  }
}







/*
//Inside Scaffold
body: StreamBuilder<Position>(
  stream: geoService.getCurrentLocation(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
    return Center(
      child: Text('Lat: ${snapshot.data.latitude},  Lng: ${snapshot.data.longitude}', style: TextStyle(fontSize: 20),),
    );
  },
),*/
