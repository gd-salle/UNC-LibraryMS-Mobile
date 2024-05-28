import 'package:flutter/material.dart';
import '../route/app_routes.dart';

class CourseDetailsPage extends StatelessWidget {
  final Map<String, dynamic> department;

  CourseDetailsPage({required this.department});

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
            'assets/logo.png', // Your university logo asset
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
                  width: 4,
                  height: 24,
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  department['department'],
                  style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            ...department['courses'].map<Widget>((course) {
              return ListTile(
                title: Text(
                  course['course'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.subjectDetailsPage,
                      arguments: course,
                    );
                  },
                  child: Text(
                    'View Subjects',
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
