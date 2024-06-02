import 'course.dart';

class Department {
  final int id; // Add this line
  final String name;
  final List<Course> courses;

  Department({required this.id, required this.name, required this.courses}); // Add 'id' parameter

  factory Department.fromJson(Map<String, dynamic> json) {
    var list = json['course'] as List;
    List<Course> courseList = list.map((i) => Course.fromJson(i)).toList();

    if (json['id'] == null) {
      throw Exception('Department id is missing');
    }

    return Department(
      id: json['id'], // Add this line
      name: json['name'] ?? '',
      courses: courseList,
    );
  }
}
