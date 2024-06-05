import 'package:flutter/material.dart';
import '../models/books.dart';
import '../services/google_books_api_service.dart';
import '../widgets/sidebar.dart';

class AddBookReferencePage extends StatefulWidget {
  @override
  _AddBookReferencePageState createState() => _AddBookReferencePageState();
}

class _AddBookReferencePageState extends State<AddBookReferencePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> _bookList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchRandomBooks();
  }

  Future<void> _fetchRandomBooks() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final results = await GoogleBooksApiService.fetchRandomBooks();
      setState(() {
        _bookList = results;
      });
    } catch (e) {
      // Handle error if needed
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _searchBooks() async {
    setState(() {
      _isLoading = true;
      _bookList = [];
    });
    try {
      if (_searchController.text.isEmpty) {
        _fetchRandomBooks();
      } else {
        final results = await GoogleBooksApiService.searchBooks(_searchController.text);
        setState(() {
          _bookList = results;
        });
      }
    } catch (e) {
      // Handle error if needed
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Back',
            style: TextStyle(color: Colors.red),
          ),
        ),
        title: Center(
          child: Image.asset(
            'images/2x/LOGO@2x.png', // Your university logo asset
            height: 40,
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.red),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Sidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 15,
                  height: 60,
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  'Add Book Reference',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onSubmitted: (value) => _searchBooks(),
            ),
            SizedBox(height: 16),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _bookList.length,
                      itemBuilder: (context, index) {
                        final book = _bookList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  if (book.thumbnailUrl.isNotEmpty)
                                    Image.network(
                                      book.thumbnailUrl,
                                      width: 60, // Increased width
                                      height: 80, // Increased height
                                      fit: BoxFit.cover,
                                    )
                                  else
                                    Container(
                                      width: 60, // Increased width
                                      height: 80, // Increased height
                                      color: Colors.grey,
                                      child: Icon(Icons.book, color: Colors.white),
                                    ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          book.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Author: ${book.authors.join(', ')}',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          'Publisher: ${book.publisher}, ${book.publishedDate}',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () {
                                              // Implement the add book functionality
                                            },
                                            child: Text(
                                              'Add to List',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              
                              Divider(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
