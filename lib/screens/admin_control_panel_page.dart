import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../route/app_routes.dart'; // Add this import

class AdminControlPanelPage extends StatelessWidget {
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
                  'Admin Control Panel',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Manage Curriculum'),
              trailing: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.manageCurriculumPage); // Update this line
                },
                child: Text(
                  'View',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}