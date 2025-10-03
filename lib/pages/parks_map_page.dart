import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParksMapPage extends StatefulWidget {
  const ParksMapPage({super.key});

  @override
  State<ParksMapPage> createState() => _ParksMapPageState();
}

class _ParksMapPageState extends State<ParksMapPage> {
  List parks = [];
  Set<Marker> _markers = {};


  @override
  void initState() {
    super.initState();
    loadParks();
  }

Future<void> loadParks() async {
  final data = await rootBundle.loadString('assets/florida_parks.json');
  final List decoded = json.decode(data);

  // Filter out parks with missing coords
  final validParks = decoded.where((park) {
    final lat = park["lat"];
    final lng = park["lng"];
    return lat != null && lng != null;
  }).take(6); // 👈 only take 6

  final validMarkers = validParks.map((park) {
    final lat = (park["lat"] as num).toDouble();
    final lng = (park["lng"] as num).toDouble();
    final name = park["name"]?.toString() ?? "Unnamed Park";
    final price = park["price"]?.toString() ?? "No price info";

    return Marker(
      markerId: MarkerId(name),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: name, snippet: price),
    );
  }).toSet();

  setState(() {
    parks = decoded;
    _markers
      ..clear()
      ..addAll(validMarkers);
  });
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Parks Map")),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(28.5, -82.0), // Central Florida
          zoom: 7,
        ),
        markers: _markers,
      ),
    );
  }
}
