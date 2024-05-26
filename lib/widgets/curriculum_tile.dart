import 'package:flutter/material.dart';

class CurriculumTile extends StatefulWidget {
  final Map<String, dynamic> course;

  CurriculumTile({required this.course});

  @override
  _CurriculumTileState createState() => _CurriculumTileState();
}

class _CurriculumTileState extends State<CurriculumTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.course['title'],
          style: TextStyle(
            fontSize: 18, 
            fontWeight:  FontWeight.bold,
            fontFamily: 'League Spartan'),),
          trailing: TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'Minimize' : 'View Courses',
              style: TextStyle(
                color: Colors.red,
                fontSize: 11),
            ),
          ),
        ),
        if (_isExpanded && widget.course.containsKey('subjects'))
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (widget.course['subjects'] as List<String>).map((subject) {
                return ListTile(
                  title: Text(
                    subject,
                    style: TextStyle(
                      fontSize: 13, 
                      fontWeight: FontWeight.bold,
                      fontFamily: 'League Spartan')),
                  trailing: TextButton(
                    onPressed: () {
                      // Implement view subjects action
                    },
                    child: Text(
                      'View Subjects',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 11),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        Divider(),
      ],
    );
  }
}
