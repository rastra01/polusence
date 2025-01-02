import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<String> dates = []; // Untuk menyimpan tanggal
  List<double> coValues = []; // Nilai karbon monoksida per hari
  List<double> pm25Values = []; // Nilai PM2.5 per hari
  List<double> so2Values = []; // Nilai SO2 per hari
  List<double> no2Values = []; // Nilai NO2 per hari

  @override
  void initState() {
    super.initState();
    _getAirQualityData(); // Memanggil fungsi untuk mengambil data kualitas udara
  }

  // Fungsi untuk mendapatkan data kualitas udara dari Realtime Database
  void _getAirQualityData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref().child('air_quality').child(userId);

      databaseReference.once().then((DatabaseEvent snapshot) {
        if (snapshot.snapshot.exists) {
          final data = snapshot.snapshot.value as Map<dynamic, dynamic>;

          // Menyimpan data ke dalam list
          Map<String, List<Map<String, dynamic>>> groupedData = {};

          data.forEach((key, entry) {
            String date = entry['date'];
            double co = entry['co']?.toDouble() ?? 0.0;
            double pm25 = entry['pm25']?.toDouble() ?? 0.0;
            double so2 = entry['so2']?.toDouble() ?? 0.0;
            double no2 = entry['no2']?.toDouble() ?? 0.0;

            // Mengelompokkan data berdasarkan tanggal
            if (groupedData.containsKey(date)) {
              groupedData[date]!.add({
                'co': co,
                'pm25': pm25,
                'so2': so2,
                'no2': no2,
              });
            } else {
              groupedData[date] = [
                {
                  'co': co,
                  'pm25': pm25,
                  'so2': so2,
                  'no2': no2,
                }
              ];
            }
          });

          // Hitung rata-rata per tanggal
          groupedData.forEach((date, entries) {
            double totalCO = 0;
            double totalPM25 = 0;
            double totalSO2 = 0;
            double totalNO2 = 0;

            entries.forEach((value) {
              totalCO += value['co'];
              totalPM25 += value['pm25'];
              totalSO2 += value['so2'];
              totalNO2 += value['no2'];
            });

            dates.add(date);
            coValues.add(totalCO / entries.length);
            pm25Values.add(totalPM25 / entries.length);
            so2Values.add(totalSO2 / entries.length);
            no2Values.add(totalNO2 / entries.length);
          });

          // Mengurutkan data berdasarkan tanggal
          _sortAndAlignData();
          setState(() {}); // Memperbarui tampilan setelah data diambil
        } else {
          print("Data tidak ditemukan");
        }
      }).catchError((error) {
        print("Gagal mengambil data kualitas udara: $error");
      });
    } else {
      print("Pengguna tidak terautentikasi");
    }
  }

  void _sortAndAlignData() {
    // Mengurutkan berdasarkan tanggal
    var combinedData = List.generate(
        dates.length,
        (index) => {
              'date': dates[index],
              'co': coValues[index],
              'pm25': pm25Values[index],
              'so2': so2Values[index],
              'no2': no2Values[index],
            });

    combinedData.sort((a, b) {
      final dateA = a['date'] as String? ?? '';
      final dateB = b['date'] as String? ?? '';
      return dateA.compareTo(dateB);
    });

    // Clear the original lists
    dates.clear();
    coValues.clear();
    pm25Values.clear();
    so2Values.clear();
    no2Values.clear();

    // Masukkan kembali data yang terurut ke dalam lists yang sesuai
    for (var entry in combinedData) {
      dates.add(entry['date'] as String);
      coValues.add((entry['co'] as num).toDouble());
      pm25Values.add((entry['pm25'] as num).toDouble());
      so2Values.add((entry['so2'] as num).toDouble());
      no2Values.add((entry['no2'] as num).toDouble());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Statistik'),
        backgroundColor: const Color(0xFF49B02D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildChartCard(
                  'Karbon Monoksida (CO)', Colors.blue, dates, coValues),
              const SizedBox(height: 16),
              _buildChartCard('Particulate Matter (PM2.5)', Colors.green, dates,
                  pm25Values),
              const SizedBox(height: 16),
              _buildChartCard(
                  'Sulfur Dioksida (SO2)', Colors.orange, dates, so2Values),
              const SizedBox(height: 16),
              _buildChartCard(
                  'Nitrogen Dioksida (NO2)', Colors.cyan, dates, no2Values),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard(
      String title, Color color, List<String> dates, List<double> data) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                LineSeries<double, String>(
                  dataSource: data,
                  xValueMapper: (double value, int index) => dates[index],
                  yValueMapper: (double value, _) => value,
                  color: color,
                  name: title,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}