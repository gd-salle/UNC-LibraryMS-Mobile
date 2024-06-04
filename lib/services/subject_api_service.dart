import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/subject.dart';

class SubjectApiService {
  static const String apiUrl = 'http://10.0.2.2/acquire_REST_API'; // Replace with your API URL

  // Fetch subjects from the database
  static Future<List<Subject>> fetchSubjects() async {
    final response = await http.get(Uri.parse('$apiUrl/subject.php'));

    if (response.statusCode == 200) {
      print('Response body: ${response.body}'); // Print the response body for debugging
      List<dynamic> data = json.decode(response.body);
      return data.map((subject) => Subject.fromJson(subject)).toList();
    } else {
      throw Exception('Failed to load subjects');
    }
  }
}
