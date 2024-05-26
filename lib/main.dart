import 'package:flutter/material.dart';
import 'screens/curriculum_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(UniversityCurriculumApp());
}

class UniversityCurriculumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Curriculum',
      theme: AppTheme.lightTheme,
      home: CurriculumPage(),
    );
  }
}
