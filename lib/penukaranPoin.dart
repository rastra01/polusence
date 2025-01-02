import 'package:coba2/voucher.dart';
import 'package:coba2/authentification/setting.dart';
import 'package:flutter/material.dart';

class PenukaranPoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Data contoh untuk daftar voucher
    final List<Map<String, dynamic>> vouchers = [
      {
        'logo': 'assets/indomaret.png',
        'title': 'Potongan harga Indomaret Rp3RB',
        'tgl': 'Berlaku hingga 05/08/2024',
        'description': 'Minimal Belanja Rp5.000',
        'description2':
            'Nikmatin belanja di Alfamart dengan potongan harga 3Rb dengan cara menukarkan 13 poin',
        'poin': '13 Poin',
      },
      {
        'logo': 'assets/alfamart.png',
        'title': 'Potongan harga Alfamart Rp5RB',
        'tgl': 'Berlaku hingga 06/08/2024',
        'description': 'Minimal Belanja Rp7.000',
        'description2':
            'Nikmatin belanja di Alfamart dengan potongan harga 5Rb dengan cara menukarkan 17 poin',
        'poin': '17 Poin',
      },
      {
        'logo': 'assets/superindo.png',
        'title': 'Potongan harga SuperIndo Rp13RB',
        'tgl': 'Berlaku hingga 11/08/2024',
        'description': 'Minimal Belanja Rp10.000',
        'description2':
            'Nikmatin belanja di Alfamart dengan potongan harga 13Rb dengan cara menukarkan 20 poin',
        'poin': '20 Poin',
      },
      {
        'logo': 'assets/superindo.png',
        'title': 'Potongan harga SuperIndo Rp20RB',
        'tgl': 'Berlaku hingga 15/08/2024',
        'description': 'Minimal Belanja Rp15.000',
        'description2':
            'Nikmatin belanja di Alfamart dengan potongan harga 20Rb dengan cara menukarkan 30 poin',
        'poin': '30 Poin',
      },
      {
        'logo': 'assets/indomaret.png',
        'title': 'Potongan harga Indomaret Rp30RB',
        'tgl': 'Berlaku hingga 19/08/2024',
        'description': 'Minimal Belanja Rp25.000',
        'description2':
            'Nikmatin belanja di Alfamart dengan potongan harga 30Rb dengan cara menukarkan 35 poin',
        'poin': '35 Poin',
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
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Penukaran Voucher",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
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
                              Voucher(), // Halaman Privacy Policy
                        ),
                      );
                    },
                    child: const Text(
                      "Voucher Saya",
                      style: TextStyle(color: Colors.red),
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
                        const SizedBox(width: 15),
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
                              const SizedBox(height: 5),
                              Text(
                                voucher['description'],
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom:
                                        30.0), // Atur padding sesuai kebutuhan
                                child: Text(
                                  voucher['tgl'],
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                              const SizedBox(height: 4),
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
                                    children: <Widget>[
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top:
                                                30.0), // Atur padding atas sesuai kebutuhan
                                        child: Align(
                                          alignment: Alignment
                                              .centerRight, // Posisi teks di sebelah kanan
                                          child: Text(
                                            voucher['poin'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Tombol untuk melakukan penukaran
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top:
                                                5.0), // Atur padding atas sesuai kebutuhan
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            minimumSize: const Size(300,
                                                35), // Lebar tombol 300 dan tinggi 35
                                          ),
                                          onPressed: () {
                                            // Aksi tukar voucher
                                            Navigator.pop(context);
                                            // Tambahkan logika penukaran voucher di sini
                                          },
                                          child: const Text(
                                            "Tukar Voucher",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text("Tukar",
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
}