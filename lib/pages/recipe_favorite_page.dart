import 'package:flutter/material.dart';
import 'package:papa_study_app/datas/recipe_data.dart';

class RecipeFavoritePage extends StatelessWidget {
   RecipeFavoritePage(this.favorites, {Key? key,}) : super(key: key);
  List<FoodData> favorites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorite Recipe'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
          itemBuilder: (context,index){
            return Card(
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                child: Column(
                  children: [
                    Image.asset(favorites[index].imageUrl),
                    const SizedBox(height: 10.0),
                    Text(favorites[index].foodName,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
