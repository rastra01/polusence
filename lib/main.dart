import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'home.dart'; // Halaman Kualitas Udara
import 'statistik.dart'; // Halaman Statistik
import 'chalenge.dart'; // Halaman Tantangan
import 'setting.dart'; // Halaman Pengaturan

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    AirQualityPage(),
    StatisticsPage(),
    ChallengeApp(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[
          _currentIndex], // Menampilkan halaman sesuai dengan _currentIndex
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index; // Mengupdate indeks saat item diklik
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              color: _currentIndex == 0 ? Colors.green : Colors.grey),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart,
              color: _currentIndex == 1 ? Colors.green : Colors.grey),
          label: 'Statistics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task,
              color: _currentIndex == 2 ? Colors.green : Colors.grey),
          label: 'Challenge',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings,
              color: _currentIndex == 3 ? Colors.green : Colors.grey),
          label: 'Settings',
        ),
      ],
    );
  }
}
