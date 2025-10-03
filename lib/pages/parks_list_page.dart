import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'park_detail_page.dart';

class ParksListPage extends StatefulWidget {
  const ParksListPage({super.key});

  @override
  State<ParksListPage> createState() => _ParksListPageState();
}

class _ParksListPageState extends State<ParksListPage> {
  List parks = [];

  @override
  void initState() {
    super.initState();
    loadParks();
  }

  Future<void> loadParks() async {
    final data = await rootBundle.loadString('assets/florida_parks.json');
    setState(() {
      parks = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Florida State Parks")),
      body: ListView.builder(
        itemCount: parks.length,
        itemBuilder: (context, index) {
          final park = parks[index];
          return Card(
  child: ListTile(
    leading: const Icon(Icons.park, color: Color(0xFF2E4600)),
    title: Text(
      park["name"],
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(park["url"] ?? ""),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParkDetailPage(park: park),
        ),
      );
    },
  ),
);      
        },
      ),
    );
  }
}   

