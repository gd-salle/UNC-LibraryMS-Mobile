import 'package:flutter/material.dart';
import '../models/courses.dart';
import '../services/course_api_service.dart';
import '../widgets/sidebar.dart';
import '../services/department_api_service.dart';
import '../models/department.dart';

class ManageCoursesPage extends StatefulWidget {
  @override
  _ManageCoursesPageState createState() => _ManageCoursesPageState();
}

class _ManageCoursesPageState extends State<ManageCoursesPage> {
  late Future<List<Course>> futureCourses;
  late Future<List<Department>> futureDepartments;
  List<Course> allCourses = [];
  List<Course> filteredCourses = [];
  TextEditingController searchController = TextEditingController();
  String? selectedDepartment;
  bool isModifyMode = false;
  @override
  void initState() {
    super.initState();
    futureCourses = CourseApiService.fetchCourses();
    futureCourses.then((courses) {
      setState(() {
        allCourses = courses;
        filteredCourses = courses;
      });
    });
    searchController.addListener(_filterCourses);
    futureDepartments = DepartmentApiService.fetchDepartments();
  }

  void _filterCourses() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredCourses = allCourses.where((course) {
        return course.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _showAddCourseDialog() async {
    final success = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AddCourseDialog(
          departmentsFuture: futureDepartments,
        );
      },
    );

    if (success == true) {
      // Refresh course list
      setState(() {
        futureCourses = CourseApiService.fetchCourses();
        futureCourses.then((courses) {
          setState(() {
            allCourses = courses;
            filteredCourses = courses;
          });
        });
      });
    }
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
                  'Manage Courses',
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
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Course>>(
                future: futureCourses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No courses found'));
                  } else {
                    return ListView.builder(
                      itemCount: filteredCourses.length,
                      itemBuilder: (context, index) {
                        var course = filteredCourses[index];
                        return ListTile(
                          title: Text(course.name),
                          trailing: isModifyMode
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.red),
                                    onPressed: () {
                                      
                                    },
                                  ),
                                ],
                              )
                              : null,
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 180, // Adjust the width as needed
                  height: 40, // Adjust the height as needed
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
                  width: 180, // Adjust the width as needed
                  height: 40, // Adjust the height as needed
                  child: ElevatedButton(
                    onPressed: _showAddCourseDialog,
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

class AddCourseDialog extends StatefulWidget {
  final Future<List<Department>> departmentsFuture;

  AddCourseDialog({required this.departmentsFuture});

  @override
  _AddCourseDialogState createState() => _AddCourseDialogState();
}

class _AddCourseDialogState extends State<AddCourseDialog> {
  final TextEditingController courseNameController = TextEditingController();
  String? selectedDepartment;
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Container(
            width: 15,
            height: 60,
            color: Colors.red,
          ),
          SizedBox(width: 8),
          Text(
            'Add New Course',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: FutureBuilder<List<Department>>(
        future: widget.departmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No departments found'));
          } else {
            List<Department> departments = snapshot.data!;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Department',
                  ),
                  items: departments.map((Department department) {
                    return DropdownMenuItem<String>(
                      value: department.name,
                      child: Text(department.name),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    selectedDepartment = newValue;
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  controller: courseNameController,
                  decoration: InputDecoration(
                    labelText: 'Course Name',
                  ),
                ),
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (selectedDepartment != null && courseNameController.text.isNotEmpty) {
              var departments = await widget.departmentsFuture;
              var department = departments.firstWhere((dept) => dept.name == selectedDepartment);
              int departmentId = department.id;
              bool success = await CourseApiService.addCourse(departmentId, courseNameController.text);
              if (success) {
                Navigator.of(context).pop(true);
              } else {
                setState(() {
                  errorMessage = 'Failed to add course. Please try again.';
                });
              }
            } else {
              setState(() {
                errorMessage = 'Please fill in all fields.';
              });
            }
          },
          child: Text(
            'Confirm',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}