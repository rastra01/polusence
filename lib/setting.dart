import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'account.dart'; // Sesuaikan dengan nama file SignUp Anda
import 'contact_us.dart'; // Jika ada halaman Contact Us
import 'terms_conditions.dart'; // Jika ada halaman Terms & Conditions
import 'privacy_policy.dart'; // Jika ada halaman Privacy Policy
import 'about.dart'; // Jika ada halaman About

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SettingsTile(
              icon: Icons.person_outline,
              title: 'Account',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountPage(), // Halaman Sign Up
                  ),
                );
              },
            ),
            SettingsTile(
              icon: Icons.solar_power,
              title: 'Solar Details',
              onTap: () => handleTap('Solar Details'),
            ),
            SettingsTile(
              icon: Icons.mail_outline,
              title: 'Contact Us',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactUsPage(), // Halaman Kontak
                  ),
                );
              },
            ),
            SettingsTile(
              icon: Icons.article_outlined,
              title: 'Terms & Conditions',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TermsConditionsPage(), // Halaman Terms & Conditions
                  ),
                );
              },
            ),
            SettingsTile(
              icon: Icons.lock_outline,
              title: 'Privacy Policy',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PrivacyPolicyPage(), // Halaman Privacy Policy
                  ),
                );
              },
            ),
            SettingsTile(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutPage(), // Halaman About
                  ),
                );
              },
            ),
            SettingsTile(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () async {
                // Logic untuk logout
                await FirebaseAuth.instance.signOut();
                // Navigasi kembali ke halaman login atau homepage
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void handleTap(String title) {
    // Logika jika perlu dalam kategori yang lebih spesifik
    print('Navigating to: $title');
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(icon, color: Colors.black),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
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
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
