import 'package:flutter/material.dart';
import '../widgets/curriculum_tile.dart';

class CurriculumPage extends StatelessWidget {
  final List<Map<String, dynamic>> courses = [
    {
      'title': 'Arts and Sciences',
      'subjects': [
        'Bachelor of Arts in Psychology',
        'Bachelor of Arts in Political Science',
        'Bachelor of Arts in Biology'
      ]
    },
    {'title': 'Business and Accountancy',
    'subjects': [
        'Bachelor of Science in Accountancy',
        'Bachelor of Science in Business Administration',
        'Bachelor of Science in Entrepeneurship',
        'Bachelor of Arts Hospitality Management'
      ]
    },
    {'title': 'Computer Studies',
    'subjects': [
        'Associate in Computer Technology',
        'Bachelor of Library and Information Science',
        'Bachelor of Science in Information Technology',
        'Bachelor of Science in Computer Science'
      ]
    },
    {'title': 'Criminal Justice Education',
    'subjects': [
        'Bachelor of Science in Criminology',
      ]
    },
    {'title': 'Education',
    'subjects': [
        'Bachelor of Elementary Education',
        'Bachelor of Secondary Education',
        'Bachelor of Physical Education'
      ]
    },
    {'title': 'Engineering and Architecture',
      'subjects': [
        'Bachelor of Science in Architecture',
        'Bachelor of Science in Computer Engineering',
        'Bachelor of Science in Electrical Engineering',
        'Bachelor of Science in Mechanical Engineering',
        'Bachelor of Science in Civil Engineering',
        'Bachelor of Science in Electronics Engineering'
      ]
    },
    {'title': 'Nursing',
      'subjects': [
        'Bachelor of Science in Nursing',
        'Caregiving NC II'
      ]
    },
  ];

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
                  height: 40,
                  color: Colors.red,
                ),
                SizedBox(width: 8),
                Text(
                  'University Curriculum',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: 25, 
                    fontWeight: FontWeight.w900,
                    fontFamily: 'League Spartan'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return CurriculumTile(course: courses[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
