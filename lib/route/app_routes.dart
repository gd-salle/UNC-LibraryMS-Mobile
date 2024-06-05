import 'package:bookreferencemodule/screens/add_book_reference_page.dart';
import 'package:flutter/material.dart';
import '../screens/curriculum_page.dart';
import '../screens/course_prospectus_page.dart';
import '../models/course.dart';
import '../screens/admin_control_panel_page.dart'; 
import '../screens/manage_curriculum_page.dart'; 
import '../screens/manage_departments_page.dart'; 
import '../screens/manage_course_page.dart';
import '../screens/manage_subject_page.dart';
import '../screens/manage_book_reference_page.dart';
import '../screens/book_reference_page.dart';
class AppRoutes {
  static const String curriculumPage = '/';
  static const String subjectDetailsPage = '/subject-details';
  static const String adminControlPanelPage = '/admin-control-panel';
  static const String manageCurriculumPage = '/manage-curriculum';
  static const String manageDepartmentsPage = '/manage-departments'; 
  static const String manageCoursesPage = '/manage-courses';
  static const String manageSubjectsPage = '/manage-subjects';
  static const String manageReferencePage = '/manage-reference';
  static const String manageBookReferencePage = '/book-reference';
  static const String addBookReferencePage = '/add-book-reference';

  static Map<String, WidgetBuilder> routes = {
    curriculumPage: (context) => CurriculumPage(),
    subjectDetailsPage: (context) {
      final Course course = ModalRoute.of(context)!.settings.arguments as Course;
      return SubjectDetailsPage(course: course);
    },
    adminControlPanelPage: (context) => AdminControlPanelPage(),
    manageCurriculumPage: (context) => ManageCurriculumPage(),
    manageDepartmentsPage: (context) => ManageDepartmentsPage(), 
    manageCoursesPage: (context) => ManageCoursesPage(),
    manageSubjectsPage: (context) => ManageSubjectsPage(),
    manageReferencePage: (context) => ManageBookReferencePage(),
    manageBookReferencePage:(context){
      final String subjectName = ModalRoute.of(context)!.settings.arguments as String;
      return ViewBookReferencePage(subjectName: subjectName);
    },
    addBookReferencePage: (context) => AddBookReferencePage(),
  };
}