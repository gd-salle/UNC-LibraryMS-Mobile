import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/courses.dart';

class CourseApiService {
  static const String apiUrl = 'http://10.0.2.2/acquire_REST_API'; // Replace with your API URL

  // Fetch courses from the database
  static Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse('$apiUrl/course.php'));

    if (response.statusCode == 200) {
      print('Response body: ${response.body}'); // Print the response body for debugging
      List<dynamic> data = json.decode(response.body);
      return data.map((course) => Course.fromJson(course)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  // Add a new course to the database
  static Future<bool> addCourse(int departmentId, String name) async {
    final response = await http.post(
      Uri.parse('$apiUrl/course.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'department_id': departmentId, 
        'name': name
        }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to add course: ${response.body}'); // Print the error response body
      return false;
    }
  }
}
