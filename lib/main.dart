import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:media_tooker/screens/auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        title: 'Media Tooker',
        home: LoginScreen(),
      ),
    );
  }
}
