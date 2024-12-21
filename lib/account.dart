import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'general_info.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? fullName;
  String? gender;
  String? phone;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      print(
          "Current User UID: ${currentUser.uid}"); // Debugging: menampilkan UID pengguna
      final ref = FirebaseDatabase.instance.ref('users/${currentUser.uid}');
      final snapshot = await ref.once();

      print(
          'Snapshot value: ${snapshot.snapshot.value}'); // Debugging: menampilkan isi snapshot

      if (snapshot.snapshot.value != null) {
        if (snapshot.snapshot.value is Map) {
          Map<String, dynamic> data =
              Map<String, dynamic>.from(snapshot.snapshot.value as Map);
          setState(() {
            fullName = data['fullName'];
            gender = data['gender'];
            phone = data['phone'];
          });
        } else {
          print('Data tidak dalam format Map');
        }
      } else {
        print('Snapshot tidak ada');
      }
    } else {
      print('Pengguna tidak terautentikasi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Akun Saya"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Card
            GestureDetector(
              onTap: () {
                // Aksi ketika card ditekan
                print("Card ditekan"); // Debugging untuk memastikan responsif
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF49B02D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/profile_picture.png'), // Ganti dengan asset Anda
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName ??
                              'Nama tidak tersedia', // Menggunakan Null Check
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Gender - ${gender ?? 'Tidak diketahui'}", // Menggunakan Null Check
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Phone - ${phone ?? 'Tidak tersedia'}", // Menggunakan Null Check
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Account Details
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Account Details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // General Info
            SettingsTile(
              icon: Icons.person_outline,
              title: "General Info",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GeneralInfoPage(),
                  ),
                );
              },
            ),
            const Divider(),
            // Password
            SettingsTile(
              icon: Icons.lock_outline,
              title: "Password",
              onTap: () {
                // Pindah ke halaman Password
              },
            ),
            const Divider(),
            // Contact Info
            SettingsTile(
              icon: Icons.email_outlined,
              title: "Contact Info",
              onTap: () {
                // Pindah ke halaman Contact Info
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title,
          style: const TextStyle(fontSize: 16, color: Colors.black)),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    );
  }
}
