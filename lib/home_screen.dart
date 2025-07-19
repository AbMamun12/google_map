import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Screen')),
      body:  GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target: LatLng(25.046309375359275, 89.5541037137484),

        ),
        onTap: (LatLng?latLng){
          print(latLng);
        },
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller){
          googleMapController=controller;

        },
        trafficEnabled: true,
      ),
    );
  }
}
