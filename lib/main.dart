import 'package:flutter/material.dart';
import 'package:india_today_task/core/constants/app_colors.dart';
import 'package:india_today_task/ui/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'India Today Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: const IconThemeData(
          color: AppColors.iconColor
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: AppColors.iconColor,
          unselectedItemColor: Colors.grey
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColors.iconColor)
      ),
      home: HomeView(),
    );
  }
}
