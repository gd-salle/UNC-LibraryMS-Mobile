class Subject {
  final String name;

  Subject({required this.name});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json['subject'],
    );
  }
}
