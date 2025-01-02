import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ArticleListPage(),
    );
  }
}

class ArticleListPage extends StatelessWidget {
  final List<Map<String, String>> articles = [
    {
      'title': 'Cara Polusi Memengaruhi Kehidupan Sehari-Hari',
      'date': '08 Maret 2022',
      'image': 'assets/pabrik.jpeg',
    },
    {
      'title': 'Pengukuran Polusi Udara: Bagaimana Cara Kerjanya?',
      'date': '18 April 2024',
      'image': 'assets/pabrik.jpeg',
    },
    {
      'title': 'Polusi dan Perubahan Iklim: Apa Hubungannya?',
      'date': '28 April 2024',
      'image': 'assets/pabrik.jpeg',
    },
    {
      'title': 'Tips Mengurangi Polusi dari Aktivitas Sehari-Hari',
      'date': '30 April 2024',
      'image': 'assets/pabrik.jpeg',
    },
    {
      'title': 'Aplikasi Pengukur Polusi Udara Terbaik untuk Smartphone',
      'date': '30 April 2024',
      'image': 'assets/pabrik.jpeg',
    },
    {
      'title': 'Peran Komunitas dalam Mengurangi Polusi di Lingkungan Sekitar',
      'date': '14 Agustus 2024',
      'image': 'assets/pabrik.jpeg',
    },
    {
      'title': 'Inovasi Terbaru dalam Energi Terbarukan untuk Mengurangi Polusi',
      'date': '18 Agustus 2024',
      'image': 'assets/pabrik.jpeg',
    },
  ];

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artikel'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ListTile(
            leading: Image.asset(
              article['image']!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(
              article['title']!,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              article['date']!,
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              // Tambahkan aksi saat artikel diklik
            },
          );
        },
      ),
    );
  }
}