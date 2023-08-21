import 'package:example_project/screens/favorite_qr_codes_screen.dart';
import 'package:example_project/screens/qr_code_folders_overview_screen.dart';
import 'package:example_project/screens/qr_code_scanner_screen.dart';
import 'package:example_project/screens/qr_codes_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../utils/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    QRCodeScannerScreen(),
    QRCodeOverviewScreen(),
    FavoritesQRCodeScreen(),
    QRCodeFolderOverviewScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.qr_code),
          SizedBox(width: 10),
          Text(Config.APP_NAME),
        ],
      )),
      body: _screens.elementAt(_currentIndex),
      bottomNavigationBar: SalomonBottomBar(
        margin: const EdgeInsets.all(30),
        backgroundColor: const Color.fromARGB(255, 246, 246, 246),
        currentIndex: _currentIndex,
        onTap: (i) => setState(() {
          _currentIndex = i;
        }),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.camera_alt),
            title: const Text("Scanner"),
            selectedColor: Colors.blueAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.qr_code),
            title: const Text("QR Codes"),
            selectedColor: Theme.of(context).colorScheme.secondary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text("Favoritos"),
            selectedColor: Colors.redAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.folder),
            title: const Text("Pastas"),
            selectedColor: Colors.lightGreen,
          ),
        ],
      ),
    );
  }
}
