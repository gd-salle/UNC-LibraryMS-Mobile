import 'course.dart';

class Department {
  final String name;
  final List<Course> courses;

  Department({required this.name, required this.courses});

  factory Department.fromJson(Map<String, dynamic> json) {
    var list = json['course'] as List;
    List<Course> courseList = list.map((i) => Course.fromJson(i)).toList();

    return Department(
      name: json['name'],
      courses: courseList,
    );
  }
}
