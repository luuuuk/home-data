import 'package:flutter/material.dart';
import 'package:home_data/home.dart';
import 'package:home_data/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Data',
      theme: VisualizationTheme.theme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
