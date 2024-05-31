import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/department.dart';
import '../widgets/sidebar.dart';

class ManageDepartmentsPage extends StatefulWidget {
  @override
  _ManageDepartmentsPageState createState() => _ManageDepartmentsPageState();
}

class _ManageDepartmentsPageState extends State<ManageDepartmentsPage> {
  late Future<List<Department>> futureDepartments;

  @override
  void initState() {
    super.initState();
    futureDepartments = ApiService.fetchDepartments();
  }

  void _showAddDepartmentDialog() {
    showDialog(
      context: context,
      builder: (context) => AddDepartmentDialog(
        onConfirm: (String departmentName) {
          // Handle the add department functionality here
          print('New Department: $departmentName');
          Navigator.of(context).pop();
        },
      ),
    );
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
                  'Manage Departments',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Department>>(
                future: futureDepartments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No departments found'));
                  }

                  List<Department> departments = snapshot.data!;
                  return ListView.builder(
                    itemCount: departments.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text(
                          (index + 1).toString(),
                          style: TextStyle(color: Colors.red,fontSize: 16),
                        ),
                        title: Text(departments[index].name),
                      );
                    },
                  );
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
                    onPressed: () {
                      // Implement modify functionality here
                    },
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
                    onPressed: _showAddDepartmentDialog,
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

class AddDepartmentDialog extends StatelessWidget {
  final Function(String) onConfirm;
  final TextEditingController _controller = TextEditingController();

  AddDepartmentDialog({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  'Add New Department',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Department Name',
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 140, // Adjust the width as needed
                  height: 40, // Adjust the height as needed
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                Container(
                  width: 140, // Adjust the width as needed
                  height: 40, // Adjust the height as needed
                  child: ElevatedButton(
                    onPressed: (){
                      ApiService.addDepartment(_controller.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Confirm',
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
