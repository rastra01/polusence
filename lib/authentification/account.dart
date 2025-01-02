import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../general_info.dart';
import 'edit_profile.dart';
import 'setting.dart'; // Pastikan Anda sudah memiliki halaman ini

class AccountPage extends StatefulWidget {
  final Function(int) onNavigateTap;

  AccountPage({
    required this.onNavigateTap,
  });

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? fullName;
  String? gender;
  String? age; // Menambahkan umur
  String? phone;

  @override
  void initState() {
    super.initState();
    fetchUserProfile(); // Panggil fungsi saat state diinisialisasi
  }

  Future<void> fetchUserProfile() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final ref = FirebaseDatabase.instance.ref('users/${currentUser.uid}');
      final snapshot = await ref.once();

      if (snapshot.snapshot.value != null) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(snapshot.snapshot.value as Map);
        setState(() {
          fullName = data['fullName'];
          gender = data['gender'];
          age = data['age']; // Ambil umur
          phone = data['phone'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Akun Saya"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Colors.black), // Ikon kembali
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white, // Background putih
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      onProfileUpdated: fetchUserProfile,
                    ),
                  ),
                );
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
                      backgroundImage: AssetImage('assets/profile_picture.png'),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName ?? 'Nama tidak tersedia',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Gender: ${gender ?? 'Tidak diketahui'}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Age: ${age ?? 'Tidak diketahui'}",
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
            const Text(
              "Account Details",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // General Info
            SettingsTile(
              icon: Icons.person_outline,
              title: "General info",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GeneralInfoPage(),
                  ),
                );
              },
            ),
            const Divider(), // Garis pemisah untuk "General Info"
            // Password
            SettingsTile(
              icon: Icons.lock_outline,
              title: "Password",
              onTap: () {
                // Pindah ke halaman Password
              },
            ),
            const Divider(), // Garis pemisah untuk "Password"
            // Contact Info
            SettingsTile(
              icon: Icons.email_outlined,
              title: "Contact info",
              onTap: () {
                // Pindah ke halaman Contact Info
              },
            ),
            const Divider(), // Garis pemisah untuk "Contact info"
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
      leading: Icon(icon, color: Colors.grey),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}