import 'package:flutter/material.dart';
import '../services/subject_api_service.dart';
import '../services/course_api_service.dart';
import '../services/department_api_service.dart';
import '../models/subject.dart';
import '../models/courses.dart';
import '../models/department.dart';
import '../widgets/sidebar.dart';

class ManageSubjectsPage extends StatefulWidget {
  @override
  _ManageSubjectsPageState createState() => _ManageSubjectsPageState();
}

class _ManageSubjectsPageState extends State<ManageSubjectsPage> {
  List<Subject> subjects = [];
  List<Course> courses = [];
  List<Department> departments = [];
  String? selectedDepartment;
  String? selectedCourse;
  TextEditingController searchController = TextEditingController();
  TextEditingController subjectNameController = TextEditingController();
  bool isLoading = true;
  bool isModifyMode = false;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    setState(() {
      isLoading = true;
    });

    try {
      await fetchSubjects();
      await fetchCourses();
      await fetchDepartments();
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchSubjects() async {
    try {
      List<Subject> fetchedSubjects = await SubjectApiService.fetchSubjects();
      setState(() {
        subjects = fetchedSubjects;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> fetchCourses() async {
    try {
      List<Course> fetchedCourses = await CourseApiService.fetchCourses();
      setState(() {
        courses = fetchedCourses;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> fetchDepartments() async {
    try {
      List<Department> fetchedDepartments = await DepartmentApiService.fetchDepartments();
      setState(() {
        departments = fetchedDepartments;
      });
    } catch (e) {
      // Handle error
    }
  }

  void _showAddSubjectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    width: 15,
                    height: 40,
                    color: Colors.red,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Add New Subject',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: 'Department',
                ),
                items: departments.map((Department department) {
                  return DropdownMenuItem<int>(
                    value: department.id,
                    child: Text(department.name),
                  );
                }).toList(),
                onChanged: (int? value) {
                  setState(() {
                    selectedDepartment = value.toString();
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<int>(
              decoration: InputDecoration(
                labelText: 'Course',
              ),
              isExpanded: true, // Ensures the dropdown button expands horizontally
              items: courses.map((Course course) {
                return DropdownMenuItem<int>(
                  value: course.id,
                  child: Container( // Wrapping child in a Container
                    width: double.infinity, // Allows child to take full width
                    child: Text(
                      course.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (int? value) {
                setState(() {
                  selectedCourse = value.toString();
                });
              },
            ),

              SizedBox(height: 16),
              TextField(
                controller: subjectNameController,
                decoration: InputDecoration(
                  labelText: 'Subject Name',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Confirm', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // Add subject functionality here
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleModifyMode() {
    setState(() {
      isModifyMode = !isModifyMode;
    });
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
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
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
                        'Manage Subjects',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        // Update filtered subjects list
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: subjects.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(subjects[index].name),
                          subtitle: Text('Year: ${subjects[index].year}'),
                          trailing: isModifyMode
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {}//=> _showDeleteConfirmationDialog(departments[index].name),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.red),
                                    onPressed: () {
                                      // _showEditDepartmentDialog(departments[index].name);
                                    },
                                  ),
                                ],
                              )
                            : null,
                      );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 180,
                        height: 40,
                        child: OutlinedButton(
                          onPressed: _toggleModifyMode,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            'Modify',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      Container(
                        width: 180,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            _showAddSubjectDialog();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}