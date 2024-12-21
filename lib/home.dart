import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:coba2/formlapor.dart';

class AirQualityPage extends StatefulWidget {
  @override
  _AirQualityPageState createState() => _AirQualityPageState();
}

class _AirQualityPageState extends State<AirQualityPage> {
  String userName = '';
  String currentDate = '';

  @override
  void initState() {
    super.initState();
    _getUserInfo(); // Ambil informasi pengguna saat init state
  }

  // Fungsi untuk mendapatkan informasi pengguna
  void _getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser; // Ambil pengguna saat ini
    if (user != null) {
      String userId = user.uid; // Mengambil UID pengguna
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

      // Mengambil data pengguna dari Realtime Database berdasarkan UID
      databaseReference
          .child("users")
          .child(userId) // Menggunakan UID pengguna
          .once()
          .then((DatabaseEvent snapshot) {
        if (snapshot.snapshot.exists) {
          // Jika data ada
          final userData = snapshot.snapshot.value as Map<dynamic, dynamic>;
          setState(() {
            userName = userData['fullName'] != null
                ? userData['fullName']
                : user.email!.split('@')[0]; // Ambil nama lengkap jika ada
            currentDate = userData['dob'] != null
                ? userData['dob'] // Menggunakan tanggal lahir jika ada
                : DateTime.now()
                    .toLocal()
                    .toString()
                    .split(' ')[0]; // Format tanggal YYYY-MM-DD
          });
        } else {
          // Data tidak ada, berikan nilai default
          setState(() {
            userName = user.email!.split('@')[0]; // Ambil nama dari email
            currentDate = DateTime.now()
                .toLocal()
                .toString()
                .split(' ')[0]; // Tanggal sekarang
          });
        }
      }).catchError((error) {
        print("Gagal mengambil data pengguna: $error");
      });
    } else {
      print('Pengguna tidak terautentikasi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Mengatur background ke putih
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menampilkan nama pengguna dan tanggal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi $userName', // Menggunakan variabel userName
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          currentDate, // Menggunakan variabel currentDate
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: true, // Dummy value, sesuaikan dengan kebutuhan
                      onChanged: (value) {},
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Indeks Kualitas Udara Card
                _buildAirQualityCard(),
                SizedBox(height: 16),
                // Statistik
                _buildStatisticsGrid(),
                SizedBox(height: 16),
                // Artikel Terkait
                _buildArticleSection(),
                SizedBox(height: 16),
                // Laporkan Aktivitas
                _buildReportSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAirQualityCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.eco, size: 32, color: Colors.green),
          SizedBox(height: 8),
          Text(
            '30',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Indeks Kualitas Udara',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16),
          _buildAirQualityIndicator(),
        ],
      ),
    );
  }

  Widget _buildAirQualityIndicator() {
    return Container(
      height: 40,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('50', style: TextStyle(color: Colors.green)),
                Text('100', style: TextStyle(color: Colors.yellow)),
                Text('150', style: TextStyle(color: Colors.orange)),
                Text('200', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
          Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                colors: [
                  Colors.green,
                  Colors.yellow,
                  Colors.orange,
                  Colors.red,
                ],
                stops: [0.25, 0.5, 0.75, 1.0],
              ),
            ),
          ),
          Positioned(
            left: (30 / 200) * MediaQuery.of(context).size.width * 0.9,
            child: Container(
              width: 2,
              height: 10,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildInfoCard('Karbon Monoksida', '36.2', Icons.air),
        _buildInfoCard('Bahan Partikulat', '28.2', Icons.cloud),
        _buildInfoCard('UV Index', '1.00', Icons.sunny),
        _buildInfoCard('Humidity', '74%', Icons.water_drop),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: Colors.black),
          Spacer(),
          Text(
            value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Artikel Terkait',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildImageCard('12 Dampak polusi udara bagi kesehatan',
                  'assets/polusi1.png'),
              SizedBox(width: 16),
              _buildImageCard('10 tips mengurangi dampak polusi udara',
                  'assets/polusi2.png'),
              SizedBox(width: 16),
              _buildImageCard('5 Langkah sederhana menjaga kualitas udara',
                  'assets/polusi2.png'),
              SizedBox(width: 16),
              _buildImageCard(
                  'Bahaya polusi udara untuk anak-anak', 'assets/polusi1.png'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageCard(String title, String imagePath) {
    return Container(
      width: 240,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.5), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildReportSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bantu kami melindungi lingkungan! Laporkan kegiatan yang berpotensi mencemari udara melalui form berikut.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReportPage()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Lapor',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
