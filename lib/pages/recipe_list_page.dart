import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:papa_study_app/datas/recipe_data.dart';
import 'package:papa_study_app/pages/auth_page.dart';
import 'package:papa_study_app/pages/recipe_detail_page.dart';
import 'package:papa_study_app/pages/recipe_favorite_page.dart';
import 'package:papa_study_app/provider/page_notifier.dart';
import 'package:provider/provider.dart';

class RecipeListPage extends StatefulWidget {
  const RecipeListPage({Key? key}) : super(key: key);

  static final pageName = 'RecipeListPage';

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {

  Set<FoodData> favoritesList = Set<FoodData>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe List'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (_) => RecipeFavoritePage(favoritesList.toList())));
          }, icon: const Icon(Icons.favorite)),
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: ListView.builder(
        itemCount: foodList.length,
          itemBuilder: (context,index){
            return _showFoodList(foodList[index]);
          }),
    );
  }

  Widget _showFoodList(FoodData _foodData){
    bool _isFavorite = favoritesList.contains(_foodData);
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_)=> RecipeDetailPage(foodData: _foodData)));
          },
          child: Card(
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: Column(
                children: [
                  Image.asset(_foodData.imageUrl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_foodData.foodName,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),),
                      IconButton(
                          onPressed: (){
                            setState(() {
                              if(_isFavorite) {
                                favoritesList.remove(_foodData);
                              }else{
                                favoritesList.add(_foodData);
                              }
                            });
                          },
                          icon: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_outline,
                            color: Colors.red,))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
