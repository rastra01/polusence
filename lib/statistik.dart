import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; // Pastikan Anda memiliki paket ini di pubspec.yaml

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Mengatur background ke putih
      appBar: AppBar(
        title: const Text('Statistik'),
        backgroundColor: const Color(0xFF49B02D), // Warna app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildChartCard('Karbon Monoksida (CO)', Colors.blue,
                  'Karbon Monoksida', [10, 20, 30, 40, 50, 60, 70]),
              const SizedBox(height: 16),
              _buildChartCard('Particulate Matter', Colors.green,
                  'Bahan Partikulat', [15, 25, 35, 45, 55, 65, 75]),
              const SizedBox(height: 16),
              _buildChartCard('UV Index', Colors.orange, 'UV Index',
                  [5, 10, 15, 20, 25, 30, 35]),
              const SizedBox(height: 16),
              _buildChartCard('Humidity', Colors.cyan, 'Humidity',
                  [60, 65, 70, 75, 80, 85, 90]),
              const SizedBox(height: 16),
              _buildSummaryChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard(
      String title, Color color, String legend, List<int> data) {
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
                LineSeries<int, String>(
                  dataSource: data,
                  xValueMapper: (int value, int index) =>
                      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                  yValueMapper: (int value, _) => value,
                  color: color,
                  name: legend,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryChart() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              legend: Legend(isVisible: true),
              series: <ChartSeries>[
                LineSeries<int, String>(
                  dataSource: [10, 20, 30, 40, 50, 60, 70],
                  xValueMapper: (int value, int index) =>
                      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                  yValueMapper: (int value, _) => value,
                  color: Colors.blue,
                  name: 'Carbon Monoxide (CO)',
                ),
                LineSeries<int, String>(
                  dataSource: [15, 25, 35, 45, 55, 65, 75],
                  xValueMapper: (int value, int index) =>
                      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                  yValueMapper: (int value, _) => value,
                  color: Colors.green,
                  name: 'Particulate Matter',
                ),
                LineSeries<int, String>(
                  dataSource: [5, 10, 15, 20, 25, 30, 35],
                  xValueMapper: (int value, int index) =>
                      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                  yValueMapper: (int value, _) => value,
                  color: Colors.orange,
                  name: 'UV Index',
                ),
                LineSeries<int, String>(
                  dataSource: [60, 65, 70, 75, 80, 85, 90],
                  xValueMapper: (int value, int index) =>
                      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                  yValueMapper: (int value, _) => value,
                  color: Colors.cyan,
                  name: 'Humidity',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
