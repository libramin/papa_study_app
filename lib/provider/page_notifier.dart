import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:papa_study_app/pages/auth_page.dart';
import 'package:papa_study_app/pages/email_verification.dart';
import '../pages/recipe_list_page.dart';
import 'package:flutter/material.dart';

class PageNotifier extends ChangeNotifier {
  String _currentPage = RecipeListPage.pageName;
  String get currentPage => _currentPage;
  SignInMethodFlag _signInMethodFlag = SignInMethodFlag.email;

  PageNotifier(){
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if(user == null){

        switch(_signInMethodFlag){
          case SignInMethodFlag.google:
            GoogleSignIn().signOut();
            break;
          case SignInMethodFlag.facebook:
            // TODO: Handle this case.
            break;
          case SignInMethodFlag.apple:
            // TODO: Handle this case.
            break;
          default:
            break;
        }

        goToOtherPage(AuthPage.pageName);

      }else{

        String providerId = user.providerData.length > 0? user.providerData[0].providerId:'';
        switch (providerId){
          case 'google.com':
            _signInMethodFlag = SignInMethodFlag.google;
            break;
          case 'facebook.com':
            _signInMethodFlag = SignInMethodFlag.facebook;
            break;
          case 'apple.com':
            _signInMethodFlag = SignInMethodFlag.apple;
            break;
          default:
            _signInMethodFlag = SignInMethodFlag.email;
        }

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

enum SignInMethodFlag{
  email, google, facebook, apple
}