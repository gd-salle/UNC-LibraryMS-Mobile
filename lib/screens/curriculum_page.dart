import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/department.dart';
import '../widgets/curriculum_tile.dart';
import '../widgets/sidebar.dart';

class CurriculumPage extends StatefulWidget {
  @override
  _CurriculumPageState createState() => _CurriculumPageState();
}

class _CurriculumPageState extends State<CurriculumPage> {
  Future<List<Department>>? _departments;

  @override
  void initState() {
    super.initState();
    _departments = ApiService.fetchDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            // Implement back navigation
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
                  
                  'University Curriculum',
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
                future: _departments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No data available'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CurriculumTile(department: snapshot.data![index]);
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
