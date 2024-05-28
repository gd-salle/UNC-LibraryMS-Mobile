import 'package:flutter/material.dart';
import '../screens/curriculum_page.dart';
import '../screens/subject_details_page.dart';
import '../models/course.dart';

class AppRoutes {
  static const String curriculumPage = '/';
  static const String subjectDetailsPage = '/subject-details';

  static Map<String, WidgetBuilder> routes = {
    curriculumPage: (context) => CurriculumPage(),
    subjectDetailsPage: (context) {
      final Course course = ModalRoute.of(context)!.settings.arguments as Course;
      return SubjectDetailsPage(course: course);
    },
  };
}
