import 'package:flutter/material.dart';
import 'package:papa_study_app/datas/recipe_data.dart';
import 'package:papa_study_app/pages/recipe_detail_page.dart';

class RecipeListPage extends StatelessWidget {
  const RecipeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe List'),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.favorite)),
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
                          onPressed: (){},
                          icon: Icon(Icons.favorite,
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
