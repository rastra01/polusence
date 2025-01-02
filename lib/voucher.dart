import 'package:coba2/penukaranPoin.dart';
import 'package:coba2/authentification/setting.dart';
import 'package:flutter/material.dart';

class Voucher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Data contoh untuk daftar voucher
    final List<Map<String, dynamic>> vouchers = [
      {
        'logo': 'assets/indomaret.png',
        'title': 'Potongan harga Indomaret Rp3RB',
        'tgl': 'Berlaku hingga 05/08/2024',
        'description': 'Minimal Belanja Rp5.000\nBerlaku hingga 05/08/2024',
        'description2':
            'Nikmatin belanja di Alfamart dengan cara scan barcode dibawah',
        'poin': '13 Poin',
        'barcode': 'assets/barcode.png'
      },
      {
        'logo': 'assets/alfamart.png',
        'title': 'Potongan harga Alfamart Rp5RB',
        'tgl': 'Berlaku hingga 06/08/2024',
        'description': 'Minimal Belanja Rp7.000\nBerlaku hingga 06/08/2024',
        'description2':
            'Nikmatin belanja di Alfamart dengan cara scan barcode dibawah',
        'poin': '17 Poin',
        'barcode': 'assets/barcode.png'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Penukaran Poin"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Arahkan ke halaman tertentu, misalnya Halaman Utama
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab bar untuk pilihan Penukaran Voucher atau Voucher Saya
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PenukaranPoinPage(), // Halaman Privacy Policy
                        ),
                      );
                    },
                    child: const Text(
                      "Penukaran Voucher",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Voucher Saya",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Daftar voucher
          Expanded(
            child: ListView.builder(
              itemCount: vouchers.length,
              itemBuilder: (context, index) {
                final voucher = vouchers[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // Logo voucher
                        Image.asset(
                          voucher['logo'],
                          width: 70,
                          height: 70,
                        ),
                        const SizedBox(width: 16),
                        // Informasi voucher
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                voucher['title'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                voucher['description'],
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                voucher['poin'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Tombol Tukar
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            // Menampilkan modal bottom sheet
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: MediaQuery.of(context).size.height /
                                      3, // Membuat ukuran bottom sheet 1/4 dari tinggi layar
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Menampilkan informasi voucher
                                      Align(
                                        alignment: Alignment
                                            .centerLeft, // Posisi teks di sebelah kiri
                                        child: Text(
                                          voucher['title'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment
                                            .centerLeft, // Posisi teks di sebelah kiri
                                        child: Text(
                                          voucher['tgl'],
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      // Garis pemisah antara title dan description
                                      const Divider(
                                        color: Colors.grey, // Warna garis
                                        thickness: 1, // Ketebalan garis
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        voucher['description2'],
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 16),
                                      // Tombol untuk melakukan penukaran
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          // minimumSize: const Size(300,
                                          //     35),
                                        ),
                                        onPressed: () {
                                          // Aksi tukar voucher
                                          Navigator.pop(context);
                                          // Tambahkan logika penukaran voucher di sini
                                        },
                                        child: Image.asset(
                                          voucher['barcode'],
                                          width: 300,
                                          height: 100,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text("Gunakan",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleTap(String title) {
    // Logika jika perlu dalam kategori yang lebih spesifik
    print('Navigating to: $title');
  }
}