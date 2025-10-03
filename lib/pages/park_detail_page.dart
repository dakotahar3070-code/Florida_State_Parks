import 'package:flutter/material.dart';

class ParkDetailPage extends StatelessWidget {
  final Map park;
  const ParkDetailPage({super.key, required this.park});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(park["name"])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              park["name"],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (park["address"] != null)
              Text("📍 ${park["address"]}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            if (park["description"] != null)
              Text(park["description"], style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            if (park["amenities"] != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Amenities:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ...List<Widget>.from(
                    (park["amenities"] as List).map(
                      (a) => Text("• $a", style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            if (park["url"] != null)
              Text("More info: ${park["url"]}",
                  style: const TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}

// A detail page for a specific park, showing its name and URL.