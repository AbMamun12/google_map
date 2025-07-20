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
      body: GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target: LatLng(25.046309375359275, 89.5541037137484),
        ),
        onTap: (LatLng? latLng) {
          print(latLng);
        },
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
        trafficEnabled: true,
        markers: <Marker>{
          const Marker(
            markerId: MarkerId('ínitial-position'),
            position: LatLng(25.046309375359275, 89.5541037137484),
          ),
          Marker(
            markerId: MarkerId('home'),
            position: LatLng(25.044733059401192, 89.5530816167593),
            infoWindow: InfoWindow(
              title: 'Home',
              onTap: () {
                print('On tapped home');
              },
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueMagenta,
            ),
            draggable: true,
            onDragStart: (LatLng onStartLatlng) {
              print('On start drag $onStartLatlng');
            },
            onDragEnd: (LatLng onEndLatlng) {
              print('On End drag $onEndLatlng');
            },
          ),
        },
        circles: <Circle>{
          Circle(
            circleId: CircleId('Dengue Circle'),
            fillColor: Colors.red.withOpacity(0.4),
            center: LatLng(25.04526705539023, 89.54974662512541),
            radius: 100,
            strokeColor: Colors.blue,
            strokeWidth: 1,
            visible: true,
            onTap: () {
              print('Entered into Dengu Zone');
            },
          ),
          Circle(
            circleId: CircleId('blue Circle'),
            fillColor: Colors.blue.withOpacity(0.4),
            center: LatLng(25.04356968124803, 89.55042187124491),
            radius: 200,
            strokeColor: Colors.blue,
            strokeWidth: 1,
            visible: true,
            onTap: () {
              print('Entered into Corona Zone');
            },
          ),
        },
        polylines: <Polyline>{
          Polyline(
            polylineId: PolylineId('Random'),
            color: Colors.amber,
            width: 4,
            jointType: JointType.round,
            points: <LatLng>[
              LatLng(25.04947636897262, 89.55197352916002),
              LatLng(25.049235805947692, 89.55518815666437),
              LatLng(25.046959849829584, 89.55692823976278),
            ],
          ),
        },
        polygons: <Polygon>{
          Polygon(
            polygonId: PolygonId('Polygon-ID'),
            fillColor: Colors.pink.withOpacity(0.5),
            strokeColor: Colors.black,
            strokeWidth: 2,
            points: const <LatLng>[
              LatLng(25.044028047482954, 89.55548789352179),
              LatLng(25.044028047482954, 89.56046607345343),
              LatLng(25.041341917971543, 89.55480124801397),
              LatLng(25.041546956506174, 89.5601462200284),
              LatLng(25.03996344259818, 89.55732151865959),
              LatLng(25.04560027013909, 89.55787807703018),
            ],
          ),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 17,
                target: LatLng(25.046309375359275, 89.5541037137484),
              ),
            ),
          );
        },
        child: Icon(Icons.location_history),
      ),
    );
  }
}
