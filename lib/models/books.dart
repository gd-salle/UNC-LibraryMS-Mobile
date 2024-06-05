class Book {
  final String title;
  final List<String> authors;
  final String thumbnailUrl;
  final String publisher;
  final String publishedDate;

  Book({
    required this.title,
    required this.authors,
    required this.thumbnailUrl,
    required this.publisher,
    required this.publishedDate,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['volumeInfo']['title'] ?? 'No title available',
      authors: (json['volumeInfo']['authors'] as List<dynamic>?)
              ?.map((author) => author as String)
              .toList() ??
          ['Unknown author'],
      thumbnailUrl: json['volumeInfo']['imageLinks'] != null
          ? json['volumeInfo']['imageLinks']['thumbnail']
          : '',
      publisher: json['volumeInfo']['publisher'] ?? 'Unknown publisher',
      publishedDate: json['volumeInfo']['publishedDate'] ?? 'Unknown date',
    );
  }
}
