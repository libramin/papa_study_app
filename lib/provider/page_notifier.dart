import '../pages/recipe_list_page.dart';
import 'package:flutter/material.dart';

class PageNotifier extends ChangeNotifier {
  String _currentPage = RecipeListPage.pageName;
  String get currentPage => _currentPage;

  void goToMain (){
    _currentPage =  RecipeListPage.pageName;
    notifyListeners();
  }

  void goToOtherPage (String page){
    _currentPage = page;
    notifyListeners();
  }
}