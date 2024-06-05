import 'package:flutter/material.dart';
import '../route/app_routes.dart';
import '../widgets/sidebar.dart';
import '../services/subject_api_service.dart';
import '../services/course_api_service.dart';
import '../models/subject.dart';
import '../models/courses.dart';

class ManageBookReferencePage extends StatefulWidget {
  @override
  _ManageBookReferencePageState createState() => _ManageBookReferencePageState();
}

class _ManageBookReferencePageState extends State<ManageBookReferencePage> {
  late Future<List<Subject>> futureSubjects;

  @override
  void initState() {
    super.initState();
    futureSubjects = SubjectApiService.fetchSubjects();
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
                Text(
                  'Manage Book References',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<Subject>>(
                future: futureSubjects,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No subjects found'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Subject subject = snapshot.data![index];
                        return FutureBuilder<Course>(
                          future: CourseApiService.fetchCourseById(subject.courseId),
                          builder: (context, courseSnapshot) {
                            if (courseSnapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (courseSnapshot.hasError) {
                              return ListTile(
                                leading: Text(
                                  '${index + 1}',
                                  style: TextStyle(color: Colors.red),
                                ),
                                title: Text('Error: ${courseSnapshot.error}'),
                              );
                            } else if (!courseSnapshot.hasData) {
                              return ListTile(
                                leading: Text(
                                  '${index + 1}',
                                  style: TextStyle(color: Colors.red),
                                ),
                                title: Text('Course not found'),
                              );
                            } else {
                              Course course = courseSnapshot.data!;
                              return ListTile(
                                leading: Text(
                                  '${index + 1}',
                                  style: TextStyle(color: Colors.red),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      subject.name,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text('Course: ${course.name}',
                                    style: TextStyle(fontSize: 11),),
                                    
                                  ],
                                ),
                                trailing: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.manageBookReferencePage,
                                      arguments: subject.name,
                                    );
                                  },
                                  child: Text(
                                    'View',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}