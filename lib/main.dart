import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'route/app_routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Curriculum',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.curriculumPage,
      routes: AppRoutes.routes,
    );
  }
}
