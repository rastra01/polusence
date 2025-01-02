import 'dart:convert';
import 'package:http/http.dart' as http;

class AirQualityService {
  final String apiKey = 'fd1fca963656743ea78d7424f2efd150';
  final String baseUrl = 'http://api.openweathermap.org/data/2.5/air_pollution';

  Future<Map<String, dynamic>> getAirQuality(double lat, double lon) async {
    final response =
        await http.get(Uri.parse('$baseUrl?lat=$lat&lon=$lon&appid=$apiKey'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal mengambil data kualitas udara');
    }
  }
}