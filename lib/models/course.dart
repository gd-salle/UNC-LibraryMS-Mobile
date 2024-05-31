class Course {
  final String name;
  final Map<String, List<String>> subjects;  // Updated to Map<String, List<String>>

  Course({required this.name, required this.subjects});

  factory Course.fromJson(Map<String, dynamic> json) {
    Map<String, List<String>> subjects = {};
    (json['subjects'] as List).forEach((subject) {
      String year = subject['year'];
      if (!subjects.containsKey(year)) {
        subjects[year] = [];
      }
      subjects[year]!.add(subject['name']);
    });

    return Course(
      name: json['name'],
      subjects: subjects,
    );
  }
}
