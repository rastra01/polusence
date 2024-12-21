import 'package:coba2/authentification/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccountCreatedPage(),
    );
  }
}

class AccountCreatedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green, // Latar belakang hijau penuh
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ilustrasi di bagian atas
              Image.asset(
                'assets/environment_login.png', // Ganti dengan gambar ilustrasi yang sesuai
                width: 250, // Ukuran gambar
                height: 250,
              ),
              SizedBox(height: 20), // Jarak antara gambar dan teks
              Icon(
                Icons.check_circle,
                size: 70,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'Your Account Has Been Created!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20), // Jarak antara teks dan tombol
              // Tombol Continue di bagian bawah
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Continue'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green[500],
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
