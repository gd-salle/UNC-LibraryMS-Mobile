class Subject {
  final int id;
  final int courseId;
  final String name;
  final String year;

  Subject({
    required this.id,
    required this.courseId,
    required this.name,
    required this.year,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      courseId: json['course_id'],
      name: json['name'],
      year: json['year'],
    );
  }
}