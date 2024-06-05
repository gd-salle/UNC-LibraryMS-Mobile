import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/books.dart';

class GoogleBooksApiService {
  static const String apiUrl = 'https://www.googleapis.com/books/v1/volumes';
  static const String apiKey = 'AIzaSyBIBATeNw-BfYdwMdb5b03jqpkXHFSb4is';
  static final List<String> randomWords = ['computer', 'science', 'law', 'programming', 'data_structure', 'algorithms',];

  static Future<List<Book>> searchBooks(String query) async {
    final response = await http.get(Uri.parse('$apiUrl?q=$query&key=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      return items.map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch books');
    }
  }

  static Future<List<Book>> fetchRandomBooks() async {
    final random = Random();
    final randomIndex = random.nextInt(randomWords.length);
    final randomWord = randomWords[randomIndex];

    final response = await http.get(Uri.parse('$apiUrl?q=$randomWord&key=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      return items.map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch books');
    }
  }

}
