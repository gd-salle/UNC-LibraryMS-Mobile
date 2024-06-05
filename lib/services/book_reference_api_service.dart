import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_reference.dart';

class BookReferenceApiService {
  static const String apiUrl = 'http://10.0.2.2/acquire_REST_API'; // Replace with your API URL

  // Fetch book references from the database
  static Future<List<BookReference>> fetchBookReferences() async {
    final response = await http.get(Uri.parse('$apiUrl/book_reference.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((bookReference) => BookReference.fromJson(bookReference)).toList();
    } else {
      throw Exception('Failed to load book references');
    }
  }
}
