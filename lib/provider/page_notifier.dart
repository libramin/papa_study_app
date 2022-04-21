import 'package:firebase_auth/firebase_auth.dart';
import 'package:papa_study_app/pages/auth_page.dart';
import 'package:papa_study_app/pages/email_verification.dart';
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
        if(user.emailVerified) {
          goToMain();
        }
        else{
          goToOtherPage(CheckYourEmail.pageName);
        }
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

  void refresh()async{
    await FirebaseAuth.instance.currentUser!.reload();
    User user = FirebaseAuth.instance.currentUser!;
    print('user data : ${user.toString()}');
    if(user == null){
      goToOtherPage(AuthPage.pageName);
    }else{
      if(user.emailVerified) {
        goToMain();
      }
      else{
        goToOtherPage(CheckYourEmail.pageName);
      }
    }
  }
}