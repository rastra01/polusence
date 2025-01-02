import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:coba2/formlapor.dart';
import 'services/air_quality_service.dart'; // Import service Anda



class AirQualityPage extends StatefulWidget {
  @override
  _AirQualityPageState createState() => _AirQualityPageState();
}

class _AirQualityPageState extends State<AirQualityPage> {
  String userName = '';
  String currentDate = '';
  int airQualityIndex = 0; // Variabel untuk menyimpan indeks kualitas udara
  double coValue = 0.0; // Nilai karbon monoksida
  double pm25Value = 0.0; // Nilai bahan partikulat (PM2.5)
  double so2Value = 0.0; // Nilai Sulfur Dioksida
  double no2Value = 0.0; // Nilai Nitrogen Dioksida

  @override
  void initState() {
    super.initState();
    _getUserInfo(); // Ambil informasi pengguna
    _getAirQualityData(); // Ambil data kualitas udara
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

  // Fungsi untuk mendapatkan data kualitas udara
  void _getAirQualityData() async {
    AirQualityService airQualityService = AirQualityService();
    double lat = -7.7956; // Latitude Yogyakarta
    double lon = 110.3695; // Longitude Yogyakarta

    try {
      Map<String, dynamic> airQualityData =
          await airQualityService.getAirQuality(lat, lon);

      setState(() {
        airQualityIndex = airQualityData['list'][0]['main']['aqi'];
        coValue = airQualityData['list'][0]['components']['co'];
        pm25Value = airQualityData['list'][0]['components']['pm2_5'];
        so2Value =
            airQualityData['list'][0]['components']['so2']; // Ambil data SO2
        no2Value =
            airQualityData['list'][0]['components']['no2']; // Ambil data NO2
      });

      // Ambil UID pengguna untuk digunakan sebagai referensi penyimpanan
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        String timestamp = DateTime.now()
            .millisecondsSinceEpoch
            .toString(); // Menggunakan timestamp sebagai ID yang valid

        // Simpan data ke Realtime Database dengan UID sebagai referensi
        DatabaseReference databaseReference = FirebaseDatabase.instance
            .ref()
            .child('air_quality')
            .child(userId)
            .child(timestamp);
        await databaseReference.set({
          'date': DateTime.now().toString(), // Tanggal pengambilan data
          'aqi': airQualityIndex,
          'co': coValue,
          'pm25': pm25Value,
          'so2': so2Value,
          'no2': no2Value,
        });
      } else {
        print('Pengguna tidak terautentikasi');
      }
    } catch (error) {
      print("Gagal mengambil data kualitas udara: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          airQualityIndex.toString(),
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildColorBox(Colors.green, '1'),
            _buildColorBox(Colors.lightGreen, '2'),
            _buildColorBox(Colors.yellow, '3'),
            _buildColorBox(Colors.orange, '4'),
            _buildColorBox(Colors.red, '5'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildColorBox(Color color, String label) {
  return Column(
    children: [
      Container(
        width: 24,
        height: 8,
        color: color,
      ),
      SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    ],
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
        _buildInfoCard(
            'Karbon Monoksida (CO)', coValue.toStringAsFixed(2), Icons.air),
        _buildInfoCard('Bahan Partikulat (PM2.5)', pm25Value.toStringAsFixed(2),
            Icons.cloud),
        _buildInfoCard('Sulfur Dioksida (SO2)', so2Value.toStringAsFixed(2),
            Icons.cloud), // Data SO2
        _buildInfoCard('Nitrogen Dioksida (NO2)', no2Value.toStringAsFixed(2),
            Icons.cloud), // Data NO2
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