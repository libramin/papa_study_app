import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:papa_study_app/pages/auth_page.dart';
import 'package:papa_study_app/pages/recipe_list_page.dart';
import 'package:papa_study_app/provider/page_notifier.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
        builder: (context,snapshot){

        if(snapshot.hasError){
          return Container(child: Center(child: Text('에러, 다시 실행 해주세요!'),),);
        }
        if(snapshot.connectionState == ConnectionState.done){
          return PapaStudyApp();
        }
        return CircularProgressIndicator();

        });
  }
}


class PapaStudyApp extends StatelessWidget {
  PapaStudyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>PageNotifier())
      ],
      child: MaterialApp(
        title: 'The CodingPapa Study App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Consumer<PageNotifier>(
          builder: (context, pageNotifier, child){
            return Navigator(
              pages : [
                MaterialPage(
                    key: ValueKey(RecipeListPage.pageName),
                    child: RecipeListPage()),
                if(pageNotifier.currentPage == AuthPage.pageName) AuthPage(),
              ],
              onPopPage: (route,result){
                if(!route.didPop(result)){
                  return false;
                } return true;
              },
            );
          },
        ),
      ),
    );
  }
}
