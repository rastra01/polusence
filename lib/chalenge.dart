import 'package:flutter/material.dart';

class ChallengeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChallengeScreen(),
    );
  }
}

class ChallengeScreen extends StatefulWidget {
  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  List<Challenge> challenges = [
    Challenge(
        "Pengguna mendapatkan poin hanya dengan membuka aplikasi setiap hari",
        5,
        true,
        Colors.pink.shade100),
    Challenge(
        "Melakukan kegiatan yang ramah lingkungan, seperti pembalikan sampah",
        10,
        true,
        Colors.purple.shade100),
    Challenge("Membuka halaman statistik", 17, true, Colors.blue.shade100),
    Challenge(
        "Membaca minimal 3 artikel edukasi", 30, false, Colors.yellow.shade100),
    Challenge("Melakukan penukaran poin", 35, false, Colors.orange.shade100),
    Challenge("Melakukan Backflip", 5, false, Colors.green.shade100),
  ];

  void showChallengeDetails(Challenge challenge) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detail Misi",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text("${challenge.description}", style: TextStyle(fontSize: 16)),
              SizedBox(height: 4),
              Text("Points: ${challenge.points}",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 4),
              Text("Batas Waktu: 05:00 WIB - 23:59 WIB",
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text("Upload Bukti"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Challenge"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {},
                    ),
                    Text(
                      "Desember, 2024",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Text(
                        "28\nMinggu",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Text(
                        "29\nSenin",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Text(
                        "30\nSelasa",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Text(
                        "1\nRabu",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                PoinWidget(
                  poin: 147,
                  onTukarPoin: () {
                    // Tambahkan logika untuk Tukar Poin di sini
                    print("Tukar Poin ditekan!");
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Misi Hari Ini",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                LinearProgressIndicator(
                    value: 0.75, backgroundColor: Colors.grey.shade300),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: challenges.length,
              itemBuilder: (context, index) {
                final challenge = challenges[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Card(
                    color: challenge.color,
                    child: ListTile(
                      leading: Icon(
                        challenge.isCompleted
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color:
                            challenge.isCompleted ? Colors.green : Colors.grey,
                      ),
                      title: Text(challenge.description),
                      subtitle: Text("${challenge.points} Poin"),
                      trailing: Text(
                          challenge.isCompleted ? "Klaim" : "Belum Selesai"),
                      onTap: () => showChallengeDetails(challenge),
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

class PoinWidget extends StatelessWidget {
  final int poin;
  final VoidCallback onTukarPoin;

  PoinWidget({required this.poin, required this.onTukarPoin});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 120, // Memberi ruang lebih agar elemen tidak terpotong
          color: Colors.green,
        ),
        Positioned(
          top:
              30, // Jarak dari bagian atas agar tidak masuk ke dalam Container hijau
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.monetization_on,
                          color: Colors.orange, size: 24),
                      SizedBox(width: 8),
                      Text(
                        "$poin Poin",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: onTukarPoin,
                    child: Text(
                      "Tukar Poin",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Challenge {
  final String description;
  final int points;
  final bool isCompleted;
  final Color color;

  Challenge(this.description, this.points, this.isCompleted, this.color);
}
