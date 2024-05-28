import 'package:flutter/material.dart';
import '../models/course.dart';

class SubjectDetailsPage extends StatelessWidget {
  final Course course;

  SubjectDetailsPage({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Image.asset(
            'images/2x/LOGO@2x.png', // Your university logo asset
            height: 40,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.red),
            onPressed: () {
              // Implement menu action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 30,
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  course.name,
                  style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            ...course.subjects.map<Widget>((subject) {
              return ListTile(
                title: Text(
                  subject,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: TextButton(
                  onPressed: () {
                    // Implement subject detail navigation or action
                  },
                  child: Text(
                    'View Books',
                    style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
