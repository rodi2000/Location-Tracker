import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:live_location/screens/map.dart';
import 'package:live_location/services/geolocator_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final geoService = GeoLocatorService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context) => geoService.getInitialLocation(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<Position>(builder: (context, position, widget){
          return (position != null)
              ? Map(position)
              : Center (child: CircularProgressIndicator());
        },),
      ),
    );
  }
}