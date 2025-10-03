import 'package:flutter/material.dart';
import 'pages/parks_list_page.dart';
import 'pages/parks_map_page.dart';
import 'pages/shop_page.dart';


void main() {
  runApp(const FloridaStateParksApp());
}

class FloridaStateParksApp extends StatelessWidget {
  const FloridaStateParksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Florida State Parks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E4600),
          primary: const Color(0xFF2E4600),
          secondary: const Color(0xFFD2691E),
          background: const Color(0xFFFAF3E0),
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: Colors.black,
          onSurface: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2E4600),
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF3E0),
          cardTheme: const CardThemeData(
          color: Colors.white,
        elevation: 3,
        margin : EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
),


        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ParksListPage(),
    const ParksMapPage(),
    const ShopPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Parks'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shop'),
        ],
      ),
    );
  }
}
