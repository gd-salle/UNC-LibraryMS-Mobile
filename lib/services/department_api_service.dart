import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/department.dart';

class DepartmentApiService {
  static const String apiUrl = 'http://10.0.2.2/acquire_REST_API'; // Replace with your API URL

  // fetch departments from the database
  static Future<List<Department>> fetchDepartments() async {
    final response = await http.get(Uri.parse('$apiUrl/department.php'));

    if (response.statusCode == 200) {
      print('Response body: ${response.body}'); // Print the response body for debugging
      List<dynamic> data = json.decode(response.body);
      return data.map((department) => Department.fromJson(department)).toList();
    } else {
      throw Exception('Failed to load departments');
    }
  }

  // add a new department to the database
  static Future<void> addDepartment(String name) async {
    final response = await http.post(
      Uri.parse('$apiUrl/department.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add department');
    }
  }

  // edit an existing department in the database
  static Future<void> updateDepartment(String oldName, String newName) async {
    final response = await http.put(
      Uri.parse('$apiUrl/department.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'oldName': oldName,
        'newName': newName,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update department');
    }
  }

  // delete a department from the database
  static Future<void> deleteDepartment(String name) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/department.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete department');
    }
  }
}
