import 'package:flutter/material.dart';
import '../models/department.dart';
import '../route/app_routes.dart';

class CurriculumTile extends StatefulWidget {
  final Department department;

  const CurriculumTile({Key? key, required this.department}) : super(key: key);

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
          title: Text(
            widget.department.name,
            style: TextStyle(fontSize: 18),
          ),
          trailing: TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'Minimize' : 'View Courses',
              style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        _isExpanded
            ? Column(
                children: widget.department.courses.map((course) {
                  return ListTile(
                    title: Text(course.name, style: TextStyle(fontSize: 16)),
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
                        style: TextStyle(color: Colors.red, fontSize: 12,fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }).toList(),
              )
            : Container(),
        Divider(),
      ],
    );
  }
}
