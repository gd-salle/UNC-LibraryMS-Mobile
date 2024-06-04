class Course {
  final int id;
  final int departmentId;
  final String name;

  Course({required this.id, required this.departmentId, required this.name});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      departmentId: json['department_id'],
      name: json['name'],
    );
  }
}
