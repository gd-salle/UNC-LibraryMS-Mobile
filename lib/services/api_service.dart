import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/department.dart';

class ApiService {
  static const String apiUrl = 'http://10.0.2.2/acquire_REST_API/department.php'; // Replace with your API URL

  static Future<List<Department>> fetchDepartments() async {
    final response = await http.get(Uri.parse('$apiUrl/departments'));

    if (response.statusCode == 200) {
      print('Response body: ${response.body}'); // Print the response body for debugging
      List<dynamic> data = json.decode(response.body);
      return data.map((department) => Department.fromJson(department)).toList();
    } else {
      throw Exception('Failed to load departments');
    }
  }
}
