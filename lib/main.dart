import 'package:flutter/material.dart';
import 'package:papa_study_app/pages/recipe_list_page.dart';

void main() {
  runApp(const PapaStudyApp());
}

class PapaStudyApp extends StatelessWidget {
  const PapaStudyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The CodingPapa Study App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const RecipeListPage(),
    );
  }
}
