import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart'; // Import untuk Realtime Database

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
      home: const ReportPage(),
    );
  }
}

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String? _selectedLaporan;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Mengatur background ke putih
      appBar: AppBar(
        title: const Text('Lapor'),
        backgroundColor: Colors.white, // Latar belakang AppBar
        iconTheme:
            const IconThemeData(color: Colors.black), // Warna ikon kembali
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Back Button
            Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/environment_login.png', // Ganti dengan path aset Anda
                    height: 200,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Dropdown for report type
            const Text('Jenis Laporan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            const SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              items: [
                const DropdownMenuItem(value: 'Sampah', child: Text('Sampah')),
                const DropdownMenuItem(
                    value: 'Polusi Udara', child: Text('Polusi Udara')),
                const DropdownMenuItem(
                    value: 'Polusi Suara', child: Text('Polusi Suara')),
                const DropdownMenuItem(
                    value: 'Lainnya', child: Text('Lainnya')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedLaporan = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pilih jenis laporan',
              ),
            ),

            const SizedBox(height: 16.0),

            // Text field for description
            const Text('Deskripsi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan deskripsi tentang laporan polusi',
              ),
            ),

            const SizedBox(height: 16.0),

            // Text field for location
            const Text('Lokasi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan lokasi laporan',
              ),
            ),

            const SizedBox(height: 16.0),

            // File attachment
            const Text('Lampiran (Opsional)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Masukkan bukti foto',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  onPressed: () {}, // Aksi untuk lampiran
                  icon: const Icon(Icons.attach_file, color: Colors.green),
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            // Submit button
            Center(
              child: ElevatedButton(
                onPressed: _submitReport, // Panggil fungsi untuk menyimpan data
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100.0, vertical: 12.0),
                ),
                child: const Text('Submit', style: TextStyle(fontSize: 16.0)),
              ),
            ),

            const SizedBox(height: 16.0),

            // Contact info
            Center(
              child: const Text(
                'Nomor Kontak Pihak Berwenang:\nCall Center Lingkungan Hidup: 0800-123-1234\nCall Center Polisi: 110',
                style: TextStyle(fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menyimpan laporan ke Realtime Database
  Future<void> _submitReport() async {
    DatabaseReference reportRef = FirebaseDatabase.instance
        .ref("formlapor")
        .push(); // Referensi baru untuk laporan

    try {
      await reportRef.set({
        'jenis_laporan': _selectedLaporan,
        'deskripsi': _descriptionController.text,
        'lokasi': _locationController.text,
        'tanggal': DateTime.now().toString(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Laporan berhasil disimpan!')),
      );

      // Reset form setelah berhasil
      _selectedLaporan = null;
      _descriptionController.clear();
      _locationController.clear();
      setState(() {});
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan laporan: $error')),
      );
    }
  }
}
