import 'package:flutter/material.dart';
import 'artikelisi.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ArtikelPage(),
  ));
}

class ArtikelPage extends StatelessWidget {
  final List<Map<String, String>> articles = [
  {
    'title': 'Cara Polusi Memengaruhi Kehidupan Sehari-Hari',
    'date': '08 Maret 2022',
    'image': 'assets/pabrik.jpeg',
    'content': 'Polusi udara telah menjadi masalah global yang semakin mengkhawatirkan. '
        'Efeknya dapat dirasakan di berbagai aspek kehidupan sehari-hari, mulai dari kesehatan '
        'manusia hingga lingkungan. Paparan jangka panjang terhadap udara yang tercemar dapat '
        'meningkatkan risiko penyakit pernapasan seperti asma dan bronkitis. Selain itu, polusi '
        'udara juga berkontribusi pada perubahan iklim yang memperburuk kondisi cuaca ekstrem. '
        'Langkah-langkah seperti mengurangi emisi kendaraan, menggunakan energi terbarukan, '
        'dan menanam lebih banyak pohon menjadi solusi penting untuk mengatasi masalah ini.'
  },
  {
    'title': 'Dampak Polusi Suara terhadap Kesehatan Mental',
    'date': '15 April 2023',
    'image': 'assets/polusi3.jpg',
    'content': 'Polusi suara adalah salah satu bentuk pencemaran yang sering diabaikan, '
        'tetapi memiliki dampak serius terhadap kesehatan mental dan fisik. Suara bising '
        'yang berlebihan, seperti dari lalu lintas, konstruksi, atau mesin industri, dapat '
        'menyebabkan stres, gangguan tidur, dan bahkan masalah pendengaran. Orang yang '
        'terpapar polusi suara secara terus-menerus cenderung mengalami penurunan kualitas '
        'hidup. Penggunaan bahan peredam suara di lingkungan kerja dan perumahan, serta '
        'pembuatan zona tenang di kota-kota besar, adalah beberapa langkah efektif untuk '
        'mengurangi dampak buruknya.'
  },
  {
    'title': 'Polusi Sampah: Tantangan dan Solusi',
    'date': '10 Juni 2024',
    'image': 'assets/polusi2.jpg',
    'content': 'Polusi sampah menjadi salah satu masalah lingkungan terbesar abad ini. '
        'Penumpukan sampah plastik di lautan, misalnya, telah mengancam kehidupan laut '
        'dan ekosistem secara keseluruhan. Selain itu, pembuangan sampah yang tidak sesuai '
        'prosedur dapat mencemari tanah dan sumber air bersih. Untuk mengatasi masalah ini, '
        'revolusi dalam pengelolaan sampah diperlukan, seperti menerapkan sistem daur ulang '
        'yang lebih efisien, mengurangi penggunaan plastik sekali pakai, dan mengedukasi '
        'masyarakat tentang pentingnya pengelolaan sampah yang bertanggung jawab.'
  },
  {
    'title': 'Polusi Air: Bahaya yang Mengancam Kehidupan',
    'date': '05 September 2024',
    'image': 'assets/polusi6.jpg',
    'content': 'Polusi air adalah salah satu ancaman terbesar bagi kelangsungan hidup '
        'manusia dan ekosistem. Limbah industri, pertanian, dan rumah tangga yang dibuang '
        'ke sungai dan laut tanpa pengolahan yang memadai telah mencemari sumber air bersih. '
        'Efeknya termasuk peningkatan penyakit seperti diare, kolera, dan keracunan logam berat. '
        'Pemerintah dan masyarakat harus bekerja sama untuk meningkatkan infrastruktur pengolahan '
        'limbah, serta mempromosikan penggunaan air secara bijaksana agar masalah ini dapat diatasi.'
  },
  {
    'title': 'Polusi Cahaya: Pengaruhnya pada Kehidupan Malam',
    'date': '20 Desember 2024',
    'image': 'assets/polusi5.jpg',
    'content': 'Polusi cahaya, meskipun terlihat tidak berbahaya, memiliki dampak yang signifikan '
        'terhadap ekosistem dan kesehatan manusia. Cahaya buatan yang berlebihan mengganggu pola '
        'tidur manusia, menyebabkan gangguan pada ritme sirkadian. Selain itu, hewan malam seperti '
        'burung dan penyu juga terpengaruh oleh keberadaan cahaya yang mengacaukan navigasi alami mereka. '
        'Langkah-langkah seperti menggunakan pencahayaan yang lebih efisien dan membatasi penggunaan '
        'lampu di luar ruangan dapat membantu mengurangi dampak polusi cahaya.'
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArtikelIsiPage(
                    title: article['title']!,
                    date: article['date']!,
                    image: article['image']!,
                    content: article['content']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
