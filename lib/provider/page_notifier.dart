import 'package:firebase_auth/firebase_auth.dart';
import 'package:papa_study_app/pages/auth_page.dart';
import '../pages/recipe_list_page.dart';
import 'package:flutter/material.dart';

class PageNotifier extends ChangeNotifier {
  String _currentPage = RecipeListPage.pageName;
  String get currentPage => _currentPage;

  PageNotifier(){
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if(user == null){
        goToOtherPage(AuthPage.pageName);
      }else{
        goToMain();
      }
    });
  }

  void goToMain (){
    _currentPage =  RecipeListPage.pageName;
    notifyListeners();
  }

  void goToOtherPage (String page){
    _currentPage = page;
    notifyListeners();
  }
}