import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// GPS ->current location - lat lng
/// GPS service permission
/// GPS service on/off
/// get data from GPS

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  Position ?position;
  @override
  void initState() {
    super.initState();
    listenCurrentLocation();
  }



  Future<void> listenCurrentLocation()async{
    final isGranted = await isLocationPermissionGranted();
    if (isGranted) {
      final isServiceEnable = await checkGPSServiceEnable();
      if (isServiceEnable) {
        Geolocator.getPositionStream(
          locationSettings: LocationSettings(
           // timeLimit: Duration(seconds: 3),
            distanceFilter: 10,
            accuracy: LocationAccuracy.bestForNavigation
          )
        ).listen((pos){
          print(pos);
        });
      }  else {

        Geolocator.openLocationSettings();
      }
    } else {
      final result = await requestLocationPermission();
      if (result) {
        getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }
    Geolocator.getPositionStream().listen((pos){
      print(pos);
    });
  }

  Future<void> getCurrentLocation() async {
    final isGranted = await isLocationPermissionGranted();
    if (isGranted) {
      final isServiceEnable = await checkGPSServiceEnable();
      if (isServiceEnable) {
        Position p = await Geolocator.getCurrentPosition();
        position=p;
        setState(() {});
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      final result = await requestLocationPermission();
      if (result) {
        getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }
  }

  Future<bool> isLocationPermissionGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkGPSServiceEnable() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('My Current Location:$position'),
            ElevatedButton(
              onPressed: () {
                getCurrentLocation();
              },
              child: Text('Get current Location'),
            ),
          ],
        ),
      ),
    );
  }
}
