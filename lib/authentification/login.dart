import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart'; // Import untuk Realtime Database
import '../main.dart'; // Halaman Kualitas Udara
import 'lengkapiprofile.dart'; // Halaman Lengkapi Akun
import 'signup.dart'; // Halaman Sign Up

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
      theme: ThemeData.light(),
      home: LoginScreen(), // Mengatur halaman login sebagai halaman awal
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi untuk Login ke Firebase
  Future<void> _login(BuildContext context) async {
    try {
      // Login menggunakan email dan password
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Ambil UID dari pengguna yang terautentikasi
      String userId = userCredential.user!.uid;

      // Cek di Realtime Database
      DatabaseEvent snapshot =
          await FirebaseDatabase.instance.ref("users/$userId").once();

      if (snapshot.snapshot.exists) {
        final userData = snapshot.snapshot.value as Map<dynamic, dynamic>;

        // Memeriksa jika fullName ada
        if (userData['fullName'] != null) {
          // Jika pengguna memiliki data, navigasi ke halaman utama
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MainPage()), // Ganti dengan halaman kualitas udara
          );
        } else {
          // Jika pengguna belum memiliki data lengkap, navigasi ke halaman lengkapi profil
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Lengkapiprofile(userCredential.user!.email!)),
          );
        }
      } else {
        // Jika data pengguna tidak ditemukan, arahkan ke halaman lengkapi profil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Lengkapiprofile(userCredential.user!.email!)),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Menangani error saat login
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'Akun tidak ditemukan untuk email ini.';
          break;
        case 'wrong-password':
          message = 'Password yang Anda masukkan salah.';
          break;
        case 'invalid-email':
          message = 'Email yang Anda masukkan tidak valid.';
          break;
        default:
          message = 'Email atau password yang Anda masukkan salah.';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (error) {
      // Menangani error lain
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/environment_login.png',
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Log In',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 30),
                    // Input Email
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email, color: Colors.grey),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Input Password
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Logic untuk forgot password
                        },
                        child: const Text('Forgot Password?',
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Tombol Login
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () =>
                            _login(context), // Fungsi Login Firebase
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF49B02D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Log In',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Opsi Sign Up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF49B02D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
