import 'package:flutter/material.dart';
import '../models/course.dart';
import '../widgets/sidebar.dart';

class SubjectDetailsPage extends StatelessWidget {
  final Course course;

  SubjectDetailsPage({required this.course});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 20,
                thickness: 2,
                color: Colors.grey,
              ),
              Row(
                children: [
                  Container(
                    width: 15,
                    height: 60,
                    color: Colors.red,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      course.name,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ..._buildSubjectListByYear(course.subjects),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSubjectListByYear(Map<String, List<String>> subjectsByYear) {
    List<Widget> widgets = [];
    subjectsByYear.forEach((year, subjects) {
      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              year,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...subjects.map<Widget>((subject) {
              return ListTile(
                title: Text(
                  subject,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: TextButton(
                  onPressed: () {
                    // Implement subject detail navigation or action
                  },
                  child: Text(
                    'View Books',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 20),
          ],
        ),
      );
    });
    return widgets;
  }
}
