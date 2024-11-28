import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tzalif/data/models/user.dart';

class UserMap extends StatefulWidget {
  final Geo location_user;
  const UserMap({super.key, required this.location_user});

  @override
  State<UserMap> createState() => UserMapState();
}

class UserMapState extends State<UserMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addUserLocationMarker();
  }

  void _addUserLocationMarker() {
    final lat = double.tryParse(widget.location_user.lat ?? '0') ?? 0;
    final lng = double.tryParse(widget.location_user.lng ?? '0') ?? 0;

    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('userLocation'),
          position: LatLng(lat, lng),
          infoWindow: const InfoWindow(
            title: 'User Location',
            snippet: 'This is the user\'s location',
          ),
          // icon:
          //     BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Location Map')),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(widget.location_user.lat!),
              double.parse(widget.location_user.lng!)),
          zoom: 14.4746,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToUserLocation,
        label: const Text('Go to User'),
        icon: const Icon(Icons.location_on),
      ),
    );
  }

  Future<void> _goToUserLocation() async {
    final lat = double.tryParse(widget.location_user.lat ?? '0') ?? 0;
    final lng = double.tryParse(widget.location_user.lng ?? '0') ?? 0;
    final GoogleMapController controller = await _controller.future;

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 16.0,
        ),
      ),
    );
  }
}
