// lib/widgets/sidebar.dart

import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.indigo,
                ),
                SizedBox(height: 10),
                Text(
                  'Student',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('12-12345'),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Handle navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.request_page),
            title: Text('Book Request'),
            onTap: () {
              // Handle navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.collections_bookmark),
            title: Text('Book Collection'),
            onTap: () {
              // Handle navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Book Catalog'),
            onTap: () {
              // Handle navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Department Curriculum'),
            onTap: () {
              // Handle navigation
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign out'),
            onTap: () {
              // Handle sign out
            },
          ),
        ],
      ),
    );
  }
}
