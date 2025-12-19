import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/photo.dart';

class PhotoService {
  static const String baseUrl = 'https://api.unsplash.com';
  static const String clientId = 'd5mlvvHCupxsfMLl-Zjgcti_T9Q2zLXh4dd7MQUvLyU';

  Future<List<Photo>> searchPhotos(
    String query, {
    int page = 1,
    int perPage = 30,
  }) async {
    final url = Uri.parse(
      '$baseUrl/search/photos?query=$query&page=$page&client_id=$clientId',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      return [...results.map((json) => Photo.fromMap(json))];
    } else {
      throw Exception('Failed to load photos: ${response.statusCode}');
    }
  }
}
