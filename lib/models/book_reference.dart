class BookReference {
  final int id;
  final int subjectId;
  final String bookName;

  BookReference({
    required this.id,
    required this.subjectId,
    required this.bookName,
  });

  factory BookReference.fromJson(Map<String, dynamic> json) {
    return BookReference(
      id: json['id'],
      subjectId: json['subject_id'],
      bookName: json['book_name'],
    );
  }
}
