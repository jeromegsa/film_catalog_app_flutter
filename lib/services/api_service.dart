
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = 'a41b1c3e955291429b90863eed377db2';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<dynamic>> fetchMovies() async {
    final url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=2');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
