class Course {
  final String name;
  final List<String> subjects;

  Course({required this.name, required this.subjects});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      subjects: List<String>.from(json['subject']),
    );
  }
}
